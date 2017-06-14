#
# Autogenerated by Thrift Compiler (0.9.3)
#
# DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
#

require 'thrift'
require 'uncapitalize_types'

module UncapitalizeService
  class Client
    include ::Thrift::Client

    def uncapitalize(text)
      send_uncapitalize(text)
      return recv_uncapitalize()
    end

    def send_uncapitalize(text)
      send_message('uncapitalize', Uncapitalize_args, :text => text)
    end

    def recv_uncapitalize()
      result = receive_message(Uncapitalize_result)
      return result.success unless result.success.nil?
      raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, 'uncapitalize failed: unknown result')
    end

  end

  class Processor
    include ::Thrift::Processor

    def process_uncapitalize(seqid, iprot, oprot)
      args = read_args(iprot, Uncapitalize_args)
      result = Uncapitalize_result.new()
      result.success = @handler.uncapitalize(args.text)
      write_result(result, oprot, 'uncapitalize', seqid)
    end

  end

  # HELPER FUNCTIONS AND STRUCTURES

  class Uncapitalize_args
    include ::Thrift::Struct, ::Thrift::Struct_Union
    TEXT = 1

    FIELDS = {
      TEXT => {:type => ::Thrift::Types::STRING, :name => 'text'}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class Uncapitalize_result
    include ::Thrift::Struct, ::Thrift::Struct_Union
    SUCCESS = 0

    FIELDS = {
      SUCCESS => {:type => ::Thrift::Types::STRING, :name => 'success'}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

end

