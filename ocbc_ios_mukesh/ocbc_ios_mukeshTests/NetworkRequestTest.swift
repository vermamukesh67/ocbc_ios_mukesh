//
//  ocbc_ios_mukeshTests.swift
//  ocbc_ios_mukeshTests
//
//  Created by verma mukesh on 25/9/21.
//

import XCTest
@testable import ocbc_ios_mukesh

class NetworkRequestTest: XCTestCase {
    var apiRequest: MockAPIRequest<LoginDataResource>!
    override func setUpWithError() throws {
        apiRequest = MockAPIRequest.init(resource: LoginDataResource())
    }
    
    override func tearDownWithError() throws {
        apiRequest = nil
    }
    
    func testApiSuccessscenario() throws {
        XCTAssertEqual(apiRequest.resource.url.absoluteString, ApiRequestUrl.urlString(api: ApiRequestUrl.login), "login url is incorrect")
        XCTAssertNotNil(apiRequest.resource.urlRequest, "urlRequest should not be nil")
        XCTAssertEqual(apiRequest.resource.requestType, .POST, "method type should be POST")
        apiRequest.load { data in
            XCTAssertNotNil(data, "data should not be nil")
            XCTAssertEqual(data?.status, "success", "status should be true")
           
        } onError: { error in }
    }
}

protocol MockNetworkRequest: NetworkRequest {
}

extension MockNetworkRequest {
    func load(_ request: URLRequest, onSuccess: @escaping (ModelType?) -> Void, onError: @escaping (Error?) -> Void?) {
        
        let data = self.getData(name: "login")
        do {
            try onSuccess(self.decode(data))
        } catch let parsingError {
            onError(parsingError)
            print("Error", parsingError)
        }
        
    }
    func getData(name: String, withExtension: String = "json") -> Data {
        let bundle = Bundle(for: type(of: self))
        let fileUrl = bundle.url(forResource: name, withExtension: withExtension)
        let data = try! Data(contentsOf: fileUrl!)
        return data
    }
}

class MockAPIRequest<Resource: APIResource>: MockNetworkRequest  {
    let resource: Resource
    
    init(resource: Resource) {
        self.resource = resource
    }
    func load(onSuccess: @escaping (Resource.ModelType?) -> Void, onError: @escaping (Error?) -> Void?) {
        load(resource.urlRequest, onSuccess: onSuccess, onError: onError)
    }
    
    func decode(_ data: Data) -> Resource.ModelType? {
        let wrapper = try? JSONDecoder().decode(Resource.ModelType.self, from: data)
        return wrapper
    }
}

