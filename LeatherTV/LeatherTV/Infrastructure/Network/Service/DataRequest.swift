//
//  DataRequest.swift
//  LeatherTV
//
//  Created by Ammad Akhtar on 28/11/2021.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

protocol DataRequest {
    associatedtype Response
    
    var url: String { get }
    var method: HTTPMethod { get }
    var headers: [String : String] { get }
    var queryItems: [String : String] { get }
    
    func decode(_ data: Data) throws -> Response
}

extension DataRequest where Response: Decodable {
    
    func decode(_ data: Data) throws -> Response {
        let decoder = JSONDecoder()
        let decoded = try decoder.decode(Response.self, from: data)
        return decoded
    }
}

extension DataRequest {
    
    var headers: [String : String] {
        [:]
    }
    
    var queryItems: [String : String] {
        [:]
    }
}
