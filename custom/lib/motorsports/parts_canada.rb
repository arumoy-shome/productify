require 'net/http'

module Motorsports
  module PartsCanada
    PARTS_CA_URI = URI('https://api.partscanada.com/api/inventory?views=quantities')

    Net::HTTP.start(PARTS_CA_URI.host, PARTS_CA_URI.port, use_ssl: true) do |http|
      request = Net::HTTP::Get.new(PARTS_CA_URI)

      request.add_field('Authorization', "Bearer #{ENV['PARTS_CA_TOKEN']}")
      request.add_field('Accept', 'application/vnd.partscanada.v1+json')

      request

      http.request(request) do |response|
        require 'irb'; binding.irb
      end
    end
  end
end
