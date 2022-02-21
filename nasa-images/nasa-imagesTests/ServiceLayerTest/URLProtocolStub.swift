//
//  URLProtocolStub.swift
//  nasa-imagesTests
//
//  Created by Gabriela Sillis on 17/02/22.
//

import Foundation

// Stub 
class URLProtocolStub: URLProtocol {
    static var emit: ((URLRequest) -> Void)?
    static var data: Data?
    static var error: Error?
    static var response: HTTPURLResponse?
    
    static func observerRequest(completion: @escaping (URLRequest) -> Void) {
        URLProtocolStub.emit = completion
    }
    
    static func simulatedata(data: Data?, response: HTTPURLResponse?, error: Error?) {
        self.data = data
        self.error = error
        self.response = response
    }
    
    override open class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override open class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return  request
    }
    
    override open func startLoading() {
        URLProtocolStub.emit?(request)
        
        if let data = URLProtocolStub.data {
            client?.urlProtocol(self, didLoad: data)
        }
        
        if let response = URLProtocolStub.response {
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        }
        
        if let error = URLProtocolStub.error {
            client?.urlProtocol(self, didFailWithError: error)
        }
        client?.urlProtocolDidFinishLoading(self)
    }
    
    override open func stopLoading() {}
}
