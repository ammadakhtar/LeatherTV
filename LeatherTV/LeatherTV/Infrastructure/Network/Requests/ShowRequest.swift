//
//  ShowRequest.swift
//  LeatherTV
//
//  Created by Ammad Akhtar on 28/11/2021.
//

import Foundation

struct ShowRequest: DataRequest {
    
    var url: String {
        let baseURL: String = "https://baseURLGoesHere"
        let path: String = "pathGoesHere"
        return baseURL + path
    }
    
    var method: HTTPMethod {
        .get
    }
    
    func decode(_ data: Data) throws -> Shows {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        let response = try decoder.decode(Shows.self, from: data)
        return response
    }
}
