//
//  CustomError.swift
//  LeatherTV
//
//  Created by Ammad Akhtar on 01/12/2021.
//

import Foundation

enum CustomError: Error {
    case unableToReadFile
}

extension CustomError: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .unableToReadFile:
            return "Unable to read data from local json file."
        }
    }
}
