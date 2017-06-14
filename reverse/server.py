import glob
import os
import sys
sys.path.append('gen-py')

from reverse import ReverseService

from thrift.transport import TSocket
from thrift.transport import TTransport
from thrift.protocol import TBinaryProtocol
from thrift.server import TServer

class ReverseHandler:
    def __init__(self):
        self.log = {}

    def reverse(self,text):
        return text[::-1]

if __name__ == '__main__':
    handler = ReverseHandler()
    processor = ReverseService.Processor(handler)
    transport = TSocket.TServerSocket(port=os.environ.get('PORT', 9020))
    tfactory = TTransport.TBufferedTransportFactory()
    pfactory = TBinaryProtocol.TBinaryProtocolFactory()

    server = TServer.TSimpleServer(processor, transport, tfactory, pfactory)
    print("starting...")
    server.serve()
