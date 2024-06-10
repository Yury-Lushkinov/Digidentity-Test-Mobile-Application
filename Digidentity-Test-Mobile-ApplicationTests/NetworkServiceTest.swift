//
//  NetworkServiceTest.swift
//  Digidentity-Test-Mobile-ApplicationTests
//
//  Created by  admin on 10.06.2024.
//

import XCTest
@testable import Digidentity_Test_Mobile_Application

enum RequestTestError: Error {
    case errorTest(String)
}


final class NetworkServiceTest: XCTestCase {
    var networkService: NetworkService!
    var requestService: RequestServiceProtocolMock!

    override func setUpWithError() throws {
        requestService = RequestServiceProtocolMock()
        networkService = NetworkService(requestService: requestService)
    }

    override func tearDownWithError() throws {
        requestService = nil
        networkService = nil
    }

    func testRequest() async throws {
        requestService.sendResponceDecodableRequestURLRequestResponceClosure = { request async throws in
            XCTAssertEqual(request.url?.absoluteString, "https://marlove.net/e/mock/v1/items")
            XCTAssertNotNil(request.allHTTPHeaderFields, "request does not contain any http fields.")
            XCTAssertEqual(request.allHTTPHeaderFields?["Authorization"], "d3faa4b140a2e42f43a06cab0d69602b", "request does not contain valid Authorization field.")
            XCTAssertEqual(request.allHTTPHeaderFields?.count, 1, "request contains unexpected fields.")

            XCTAssertNil(request.url?.query(), "unexpected query params.")

            return [ItemResponce(text: "text-testRequest", confidence: 0.234, image: "image-testRequest", id: "id-testRequest")]
        }

        let responce = try await networkService.fetchItems()

        XCTAssertEqual(responce.first?.id, "id-testRequest")
    }

    func testSinceIDRequest() async throws {
        requestService.sendResponceDecodableRequestURLRequestResponceClosure = { request async throws in
            XCTAssertEqual(request.url?.absoluteString, "https://marlove.net/e/mock/v1/items?since_id=test-sinceid")
            XCTAssertNotNil(request.allHTTPHeaderFields, "request does not contain any http fields.")
            XCTAssertEqual(request.allHTTPHeaderFields?["Authorization"], "d3faa4b140a2e42f43a06cab0d69602b", "request does not contain valid Authorization field.")
            XCTAssertEqual(request.allHTTPHeaderFields?.count, 1, "request contains unexpected fields.")

            XCTAssertEqual(request.url?.query(), "since_id=test-sinceid", "wrong query params.")

            return [ItemResponce(text: "text-testRequest", confidence: 0.234, image: "image-testRequest", id: "id-testRequest")]
        }

        let responce = try await networkService.fetchItems(sinceID: "test-sinceid", maxID: nil)

        XCTAssertEqual(responce.first?.id, "id-testRequest")
    }

    func testSinceIDMaxIDRequest() async throws {
        requestService.sendResponceDecodableRequestURLRequestResponceClosure = { request async throws in
            XCTAssertEqual(request.url?.absoluteString, "https://marlove.net/e/mock/v1/items?since_id=test-sinceid&max_id=max-test")
            XCTAssertNotNil(request.allHTTPHeaderFields, "request does not contain any http fields.")
            XCTAssertEqual(request.allHTTPHeaderFields?["Authorization"], "d3faa4b140a2e42f43a06cab0d69602b", "request does not contain valid Authorization field.")
            XCTAssertEqual(request.allHTTPHeaderFields?.count, 1, "request contains unexpected fields.")

            XCTAssertEqual(request.url?.query(), "since_id=test-sinceid&max_id=max-test", "wrong query params.")

            return [ItemResponce(text: "text-testRequest", confidence: 0.234, image: "image-testRequest", id: "id-testRequest")]
        }

        let responce = try await networkService.fetchItems(sinceID: "test-sinceid", maxID: "max-test")

        XCTAssertEqual(responce.first?.id, "id-testRequest")
    }

    func testMaxIDRequest() async throws {
        requestService.sendResponceDecodableRequestURLRequestResponceClosure = { request async throws in
            XCTAssertEqual(request.url?.absoluteString, "https://marlove.net/e/mock/v1/items?max_id=max-test")
            XCTAssertNotNil(request.allHTTPHeaderFields, "request does not contain any http fields.")
            XCTAssertEqual(request.allHTTPHeaderFields?["Authorization"], "d3faa4b140a2e42f43a06cab0d69602b", "request does not contain valid Authorization field.")
            XCTAssertEqual(request.allHTTPHeaderFields?.count, 1, "request contains unexpected fields.")

            XCTAssertEqual(request.url?.query(), "max_id=max-test", "wrong query params.")

            return [ItemResponce(text: "text-testRequest", confidence: 0.234, image: "image-testRequest", id: "id-testRequest")]
        }

        let responce = try await networkService.fetchItems(sinceID: nil, maxID: "max-test")

        XCTAssertEqual(responce.first?.id, "id-testRequest")
    }

    func testMaxIDRequestThrow() async throws {
        var errorCatched = false

        requestService.sendResponceDecodableRequestURLRequestResponceClosure = { request async throws in
            XCTAssertEqual(request.url?.absoluteString, "https://marlove.net/e/mock/v1/items?max_id=max-test")
            XCTAssertNotNil(request.allHTTPHeaderFields, "request does not contain any http fields.")
            XCTAssertEqual(request.allHTTPHeaderFields?["Authorization"], "d3faa4b140a2e42f43a06cab0d69602b", "request does not contain valid Authorization field.")
            XCTAssertEqual(request.allHTTPHeaderFields?.count, 1, "request contains unexpected fields.")

            XCTAssertEqual(request.url?.query(), "max_id=max-test", "wrong query params.")

            throw RequestTestError.errorTest("testMaxIDRequestThrow-error")
        }

        do {
            let _ = try await networkService.fetchItems(sinceID: nil, maxID: "max-test")
        } catch let error as RequestTestError {
            if case  RequestTestError.errorTest(let errorString) = error,
                errorString == "testMaxIDRequestThrow-error" {
                errorCatched = true
            }
        }

        XCTAssertTrue(errorCatched, "Missed expected error.")
    }
}
