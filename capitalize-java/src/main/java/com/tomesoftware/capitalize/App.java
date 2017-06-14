package com.tomesoftware.capitalize;

import org.apache.thrift.server.TServer;
import org.apache.thrift.server.TServer.Args;
import org.apache.thrift.server.TSimpleServer;
import org.apache.thrift.server.TThreadPoolServer;
import org.apache.thrift.transport.TSSLTransportFactory;
import org.apache.thrift.transport.TServerSocket;
import org.apache.thrift.transport.TServerTransport;
import org.apache.thrift.transport.TSSLTransportFactory.TSSLTransportParameters;

import com.tomesoftware.capitalize.*;
import com.tomesoftware.capitalize.CapitalizeService.*;

public class App 
{
    public static CapitalizeHandler handler;
    public static CapitalizeService.Processor processor;

    public static void main( String[] args ) {
        try {
            handler = new CapitalizeHandler();
            processor = new CapitalizeService.Processor(handler);

            Runnable simple = new Runnable() {
                public void run() {
                    simple(processor);
                }
            };

            new Thread(simple).start();
        } catch (Exception x) {
            x.printStackTrace();
        }
    }

    public static void simple(CapitalizeService.Processor processor) {
        try {
            int port = System.getenv("PORT") != null ? Integer.valueOf(System.getenv("PORT")) : 9010;
            TServerTransport serverTransport = new TServerSocket(port);
            TServer server = new TSimpleServer(new Args(serverTransport).processor(processor));

            // Use this for a multithreaded server
            // TServer server = new TThreadPoolServer(new TThreadPoolServer.Args(serverTransport).processor(processor));

            System.out.println("Starting the simple server...");
            server.serve();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
