$:.push('gen-rb')

require 'thrift'

#require 'UncapitalizeService'
require_relative 'gen-rb/uncapitalize_constants.rb'
require_relative 'gen-rb/uncapitalize_service.rb'
require_relative 'gen-rb/uncapitalize_types.rb'

class UncapitalizeHandler
  def initialize()
    @log = {}
  end

  def uncapitalize(text)
    return text.downcase
  end

end

handler = UncapitalizeHandler.new()
processor = UncapitalizeService::Processor.new(handler)
transport = Thrift::ServerSocket.new(ENV["PORT"] || 9030)
transportFactory = Thrift::BufferedTransportFactory.new()
server = Thrift::SimpleServer.new(processor, transport, transportFactory)

puts "Starting the server..."
server.serve()
puts "done."

