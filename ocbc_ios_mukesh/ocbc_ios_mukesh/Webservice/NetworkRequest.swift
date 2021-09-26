//
//  NetworkRequest.swift
//  ocbc_ios_mukesh
//
//  Created by verma mukesh on 25/9/21.
//

import Foundation

/// A Network protocol used for api call in APIRequest class.
protocol NetworkRequest: AnyObject {
    associatedtype ModelType
    func decode(_ data: Data) throws -> ModelType?
    func load(onSuccess: @escaping (ModelType?) -> Void, onError: @escaping (Error?) -> Void?)
}

extension NetworkRequest {
    /// Excute Get or Post reqest.
    /// - Parameters:
    ///   - request: URLRequest object.
    ///   - onSuccess: A Block for success handler.
    ///   - onError: A Block for error handler.
    func load(_ request: URLRequest, onSuccess: @escaping (ModelType?) -> Void, onError: @escaping (Error?) -> Void?) {
        let session = URLSession.init(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: request, completionHandler: { [weak self] (data: Data?, response: URLResponse?, error: Error?) -> Void in
            guard let data = data else {
                onError(error)
                return
            }
            do {
                try onSuccess(self?.decode(data))
            } catch let parsingError {
                print("Error", parsingError)
            }
        })
        task.resume()
    }
}
/// A class that fetch data from given api resources.
class APIRequest<Resource: APIResource> {
    var resource: Resource
    
    init(resource: Resource) {
        self.resource = resource
    }
}

extension APIRequest: NetworkRequest {
    /// Excute Get or Post reqest.
    /// - Parameters:
    ///   - onSuccess: A Block for success handler.
    ///   - onError: A Block for error handler.
    func load(onSuccess: @escaping (Resource.ModelType?) -> Void, onError: @escaping (Error?) -> Void?) {
        load(resource.urlRequest, onSuccess: onSuccess, onError: onError)
    }
    /// Convert json data into codable class.
    /// - Parameter data: Data object
    /// - Returns: Codable model type object.
    func decode(_ data: Data) -> Resource.ModelType? {
        let wrapper = try? JSONDecoder().decode(Resource.ModelType.self, from: data)
        return wrapper
    }
}

/// A protocol that indicates  information required for each api
protocol APIResource {
    associatedtype ModelType: Decodable
    var httpBody: [AnyHashable: Any]? { get set }
    var queryItems: [URLQueryItem]? { get }
    var methodPath: String { get }
    var headerData: [String: String]? {get set}
    var requestType: ApiRequestMethodType {get set}
}
extension APIResource {
    /// A URL object for given path and query items
    var url: URL {
        var components = URLComponents(string: APIManager.baseUrl)!
        components.path = methodPath
        components.queryItems = queryItems
        return components.url!
    }
    /// A URL request object based on method type, body and headers.
    var urlRequest: URLRequest {
        let request = (requestType == .POST) ? RequestDataHelper.postRequest(url, httpBody: httpBody, headerData: headerData) : RequestDataHelper.getRequest(url, headerData: headerData)
         return request as URLRequest
    }
}
