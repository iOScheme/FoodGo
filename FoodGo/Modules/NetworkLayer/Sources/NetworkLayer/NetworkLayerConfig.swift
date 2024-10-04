//
//  File.swift
//  NetworkLayer
//
//  Created by Alex.personal on 2/10/24.
//

import Foundation

public final actor NetworkLayerConfig {
    private static let defaultPath = "www.google.com"
    public static var basePath: String {
        completion?() ?? defaultPath
    }
    
    private static var completion: (() -> String)?
    
    static func config(basePath: String) {
        completion = {
            basePath
        }
    }
}
