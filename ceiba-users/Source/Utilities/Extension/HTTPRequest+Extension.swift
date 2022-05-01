//
//  HTTPRequest+Extension.swift
//  ceiba-users
//
//  Created by Daniel Orellana on 1/05/22.
//

import Foundation

extension HTTPRequest {
    // Defaults
    var method: HTTPMethod { return .get }
    var contentType: String { return "application/json" }
    var queryParams: [String: String]? { return nil }
    var body: [String: Any]? { return nil }
    var headers: [String: String]? { return nil }
}

extension HTTPRequest {

    /// Serializes an HTTP dictionary to a JSON Data Object
    /// - Parameter params: HTTP Parameters dictionary
    /// - Returns: Encoded JSON
    private func requestBodyFrom(params: [String: Any]?) -> Data? {
        guard
            let params = params,
            let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else {

            return nil
        }

        return httpBody
    }

    /// Transforms a Request into a standard URL request
    /// - Parameter baseURL: API Base URL to be used
    /// - Returns: A ready to use URLRequest
    func asURLRequest(baseURL: String) -> URLRequest? {
        guard var urlComponents = URLComponents(string: baseURL) else { return nil }

        urlComponents.path = "\(urlComponents.path)\(path)"

        guard let finalURL = urlComponents.url else { return nil }

        var request = URLRequest(url: finalURL)
        request.httpMethod = method.rawValue
        request.httpBody = requestBodyFrom(params: body)
        request.allHTTPHeaderFields = headers

        return request
    }
}
