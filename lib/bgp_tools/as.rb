module BgpTools
  class AS
    attr_reader :country_of_origin, :prefix_list, :as_path_length, :ips_originated,
                :bgp_peer_list
    def initialize(as)
      url = "http://bgp.he.net/AS#{as}"
      result = RestClient.get url, user_agent: USER_AGENT
      self.doc = Nokogiri::HTML(result)

      set_country_of_origin
      set_prefix_list
      set_as_path_length
      set_ips_originated
      set_bgp_peer_list
    end

    def contains?(ip)
      ipaddr = IPAddr.new(ip)
      prefix_list.select {|x| x.ip_addr.include? ipaddr }.count > 0
    end

    private

    def set_as_path_length
      self.as_path_length = doc.xpath("//*[@id=\"asinfo\"]/div[2]/div[10]").first.children
      .map(&:text).map(&:strip)[0].split(':')[1].strip.to_f
    end

    def set_bgp_peer_list
      self.bgp_peer_list = doc.xpath("//*[@id=\"table_peers4\"]/tbody/tr").map do |row|
        vals = row.css('td').map(&:text)
        ipv6 = vals[2] == "X" ? true : false
        BGPPeer.new(vals[3], vals[1], ipv6, vals[0].to_i)
      end
    end



    def set_country_of_origin
      self.country_of_origin = doc.xpath("//*[@id=\"asinfo\"]/div[2]/div[2]").map(&:text)[0].strip
    end

    def set_ips_originated
      self.ips_originated = doc.xpath("//*[@id=\"asinfo\"]/div[2]/div[8]").first.children
      .map(&:text).map(&:strip)[0].split(':')[1].strip.gsub(',', '').to_i
    end

    def set_prefix_list
      self.prefix_list = doc.xpath("//*[@id=\"table_prefixes4\"]/tbody/tr").map do |row|
        vals = row.css('td').map(&:text).map(&:strip)
        ASPrefix.new(vals[1], IPAddr.new(vals[0]))
      end
    end

    attr_writer :country_of_origin, :prefix_list, :as_path_length, :ips_originated,
                :bgp_peer_list
    attr_accessor :doc
  end
end
