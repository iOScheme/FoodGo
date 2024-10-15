//
//  AppDelegate.swift
//  FoodGo
//
//  Created by Alex.personal on 7/10/24.
//

import Foundation
import UIKit
import NetworkLayer
import NLCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
}

extension AppDelegate {
    func registerRequestProvider() async throws {
        try await DependencyManager.shared.register(RequestProvider.self) {
            NetworkLayerConfig.config(host: "platform.fatsecret.com")
            let session = URLSession(configuration: .default)
            let nlCore = NetworkLayerCore(session: session)
            let networkLayer = NetworkLayer(networkLayerCore: nlCore)
            let requestProvider = RequestProvider(networkLayer: networkLayer)
            return requestProvider
        }
    }
}
