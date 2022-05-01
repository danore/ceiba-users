//
//  HTTPDispatcher+Extension.swift
//  ceiba-users
//
//  Created by Daniel Orellana on 1/05/22.
//

import Foundation

extension HTTPDispatcher {

    /// Parses a HTTP StatusCode and returns a proper error
    /// - Parameter statusCode: HTTP status code
    /// - Returns: Mapped Error
    internal func httpError(_ statusCode: Int) -> HTTPRequestError {
        switch statusCode {
        case 400: return .badRequest
        case 401: return .unauthorized
        case 403: return .forbidden
        case 404: return .notFound
        case 402, 405...499: return .error4xx(statusCode)
        case 500: return .serverError
        case 501...599: return .error5xx(statusCode)
        default: return .unknownError
        }
    }

    /// Parses URLSession Publisher errors and return proper ones
    /// - Parameter error: URLSession publisher error
    /// - Returns: Readable NetworkRequestError
    internal func handleError(_ error: Error) -> HTTPRequestError {
        switch error {
        case is Swift.DecodingError:
            return .decodingError
        case let urlError as URLError:
            return .urlSessionFailed(urlError)
        case let error as HTTPRequestError:
            return error
        default:
            return .unknownError
        }
    }
}
