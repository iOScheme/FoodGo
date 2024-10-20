//
//  RequestProviderTests.swift
//  NetworkLayer
//
//  Created by Alex.personal on 7/10/24.
//

import XCTest
import NLCore
@testable import NetworkLayer

final class RequestProviderTests: XCTestCase {
    
    func test_requestProviderSucess() async throws {
        let response =
                      """
                      
                          {
                              "firstName": "Lee",
                              "lastName": "Burrows"
                          }
                      """
        let data = response.data(using: .utf8)!
        let sut = makeSut()
        let endpoint = MockEndpoint()
        let url = try XCTUnwrap(endpoint.asURLRequest?.url)
        MockURLProtocol.error = nil
        MockURLProtocol.requestHandler = {
            request in
            let response = HTTPURLResponse(
                url:url ,
                statusCode: 200,
                httpVersion: nil,
                headerFields: ["Content-Type": "application/json"]
            )!
            return (response, data)
        }
        
        
        let result:TestPayload =  try await sut.execute(endpoint: endpoint, dto: TestPayload.self)
        XCTAssertNotNil(result)
    }
    
    func test_requestProviderDecodingFailure() async throws {
        let response =
                      """
                      
                          {
                              "firstNamew": "Lee",
                              "lastName": "Burrows"
                          }
                      """
        let data = response.data(using: .utf8)!
        let sut = makeSut()
        let endpoint = MockEndpoint()
        let url = try XCTUnwrap(endpoint.asURLRequest?.url)
        MockURLProtocol.error = nil
        MockURLProtocol.requestHandler = {
            request in
            let response = HTTPURLResponse(
                url:url ,
                statusCode: 200,
                httpVersion: nil,
                headerFields: ["Content-Type": "application/json"]
            )!
            return (response, data)
        }
        
        do {
            let _:TestPayload =  try await sut.execute(endpoint: endpoint, dto: TestPayload.self)
            XCTFail()
        } catch {
            XCTAssertNotNil(error as? DecodingError)
        }
    }
    
    func test_requestProviderStatusCodeFailure() async throws {
        let response =
                      """
                      
                          {
                              "firstName": "Lee",
                              "lastName": "Burrows"
                          }
                      """
        let data = response.data(using: .utf8)!
        let sut = makeSut()
        let endpoint = MockEndpoint()
        let url = try XCTUnwrap(endpoint.asURLRequest?.url)
        MockURLProtocol.error = nil
        MockURLProtocol.requestHandler = {
            request in
            let response = HTTPURLResponse(
                url:url ,
                statusCode: 400,
                httpVersion: nil,
                headerFields: ["Content-Type": "application/json"]
            )!
            return (response, data)
        }
        
        do {
            let _:TestPayload =  try await sut.execute(endpoint: endpoint, dto: TestPayload.self)
            XCTFail()
        } catch {
            XCTAssertNotNil(error)
        }
    }
    
    private func makeSut() -> RequestProviderProtocol {
        NetworkLayerConfig.config(host: "platform.fatsecret.com")
        let sessionConfiguraiton: URLSessionConfiguration = .ephemeral
        sessionConfiguraiton.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: sessionConfiguraiton)
        let nlCore = NetworkLayerCore(session: session)
        let networkLayer = NetworkLayer(networkLayerCore: nlCore)
        let requestProvider = RequestProvider(networkLayer: networkLayer)
        return requestProvider
    }
}

struct TestPayload: Codable {
    let firstName: String
    let lastName: String
}
