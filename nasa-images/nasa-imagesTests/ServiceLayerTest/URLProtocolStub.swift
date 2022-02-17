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
	
	static func observerRequest(completion: @escaping (URLRequest) -> Void) {
		URLProtocolStub.emit = completion
	}
	
	override open class func canInit(with request: URLRequest) -> Bool {
		return true
	}
	
	override open class func canonicalRequest(for request: URLRequest) -> URLRequest {
		return  request
	}
	
	override open func startLoading() {
		URLProtocolStub.emit?(request)
	}
	
	override open func stopLoading() {}
}
