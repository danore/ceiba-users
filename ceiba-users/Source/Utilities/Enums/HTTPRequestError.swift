//
//  HTTPRequestError.swift
//  ceiba-users
//
//  Created by Daniel Orellana on 1/05/22.
//

import Foundation
import Combine

enum HTTPRequestError: LocalizedError, Equatable {
    case invalidRequest
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case error4xx(_ code: Int)
    case serverError
    case error5xx(_ code: Int)
    case decodingError
    case urlSessionFailed(_ error: URLError)
    case unknownError
}
