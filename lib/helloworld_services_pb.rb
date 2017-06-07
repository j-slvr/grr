# Generated by the protocol buffer compiler.  DO NOT EDIT!
# Source: helloworld.proto for package 'helloworld'
# Original file comments:
# usage: grpc_tools_ruby_protoc -I ./protos --ruby_out=lib --grpc_out=lib ./protos/helloworld.proto
#

require 'grpc'
require 'helloworld_pb'

module Helloworld
  module Greeter
    # The greeting service definition.
    class Service

      include GRPC::GenericService

      self.marshal_class_method = :encode
      self.unmarshal_class_method = :decode
      self.service_name = 'helloworld.Greeter'

      # Sends a greeting
      rpc :SayHello, HelloRequest, HelloReply
      rpc :SayHelloAgain, HelloRequest, HelloReply
      rpc :HelloStream, stream(HelloRequest), stream(HelloReply)
    end

    Stub = Service.rpc_stub_class
  end
end
