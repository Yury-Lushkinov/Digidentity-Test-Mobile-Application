//
//  RequestServiceProtocolMock.swift
//  Digidentity-Test-Mobile-ApplicationTests
//
//  Created by  admin on 10.06.2024.
//

import Foundation
@testable import Digidentity_Test_Mobile_Application

class RequestServiceProtocolMock: RequestServiceProtocol {
    func send<Responce>(request: URLRequest) async throws -> Responce where Responce : Decodable {

        sendResponceDecodableRequestURLRequestResponceCallsCount += 1
        sendResponceDecodableRequestURLRequestResponceReceivedRequest = request
        sendResponceDecodableRequestURLRequestResponceReceivedInvocations.append(request)
        if let error = sendResponceDecodableRequestURLRequestResponceThrowableError {
            throw error
        }
        if let sendResponceDecodableRequestURLRequestResponceClosureInt = sendResponceDecodableRequestURLRequestResponceClosure {
            return try await sendResponceDecodableRequestURLRequestResponceClosureInt(request) as! Responce
        } else {
            return sendResponceDecodableRequestURLRequestResponceReturnValue as! Responce
        }

    }

    var sendResponceDecodableRequestURLRequestResponceThrowableError: (any Error)?
    var sendResponceDecodableRequestURLRequestResponceCallsCount = 0
    var sendResponceDecodableRequestURLRequestResponceCalled: Bool {
        return sendResponceDecodableRequestURLRequestResponceCallsCount > 0
    }
    var sendResponceDecodableRequestURLRequestResponceReceivedRequest: (URLRequest)?
    var sendResponceDecodableRequestURLRequestResponceReceivedInvocations: [(URLRequest)] = []
    var sendResponceDecodableRequestURLRequestResponceReturnValue: Decodable!
    var sendResponceDecodableRequestURLRequestResponceClosure: ((URLRequest) async throws -> Decodable)?


}
