//
//  File.swift
//  NetworkLayer
//
//  Created by Alex.personal on 2/10/24.
//

import Foundation

public protocol NetworkLayerEndpoint {
    var queryItems: [URLQueryItem] { get}
    var path: String { get }
    var method: URLRequestMethod { get }
    var asURLRequest: URLRequest? { get }
    var host: String { get }
    var scheme: String { get }
    var apiVersion: String? { get }
}

public extension NetworkLayerEndpoint {
    var host: String {
        NetworkLayerConfig.host
    }
    
    var scheme: String {
        "https"
    }
    
    var apiVersion: String? { nil }
    
    var asURLRequest: URLRequest? {
        var versionedPath: String?
        var urlComponent = URLComponents()
        urlComponent.host = host
        if let apiVersion {
            versionedPath = "\(path)\(apiVersion)"
        }
        urlComponent.path = versionedPath ?? path
        urlComponent.queryItems = queryItems
        urlComponent.scheme = scheme
       
        guard let url = urlComponent.url else { return nil }
        var  request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return request
    }
}

public enum URLRequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}
