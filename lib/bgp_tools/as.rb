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
    end

    private

    def set_as_path_length
      self.as_path_length = doc.xpath("//*[@id=\"asinfo\"]/div[2]/div[10]").first.children
      .map(&:text).map(&:strip)[0].split(':')[1].strip.to_f
    end


    def set_country_of_origin
      self.country_of_origin = doc.xpath("//*[@id=\"asinfo\"]/div[2]/div[2]").map(&:text)[0].strip
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
