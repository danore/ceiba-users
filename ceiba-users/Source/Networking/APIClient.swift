//
//  APIClient.swift
//  ceiba-users
//
//  Created by Daniel Orellana on 1/05/22.
//

import Foundation
import Combine

struct APIClient {

    var baseURL: String = "https://jsonplaceholder.typicode.com"
    var networkDispatcher: HTTPDispatcher!

    init(networkDispatcher: HTTPDispatcher = HTTPDispatcher()) {
        self.networkDispatcher = networkDispatcher
    }

    /// Dispatches a Request and returns a publisher
    /// - Parameter request: Request to Dispatch
    /// - Returns: A publisher containing decoded data or an error
    func dispatch<R: HTTPRequest>(_ request: R) -> AnyPublisher<R.ReturnType, HTTPRequestError> {
        guard let urlRequest = request.asURLRequest(baseURL: baseURL) else {
            return Fail(outputType: R.ReturnType.self, failure: HTTPRequestError.badRequest).eraseToAnyPublisher()
        }

        typealias RequestPublisher = AnyPublisher<R.ReturnType, HTTPRequestError>
        let requestPublisher: RequestPublisher = networkDispatcher.dispatch(request: urlRequest)

        return requestPublisher.eraseToAnyPublisher()
    }
}
