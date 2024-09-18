//
//  HealthkitManager.swift
//  FoodGo
//
//  Created by Alex.personal on 13/9/24.
//

import Foundation
import HealthKit

protocol HealthkitManagerProtocol {
    static var shared: HealthkitManager { get }
}

public final class HealthkitManager: HealthkitManagerProtocol, ObservableObject {
    
    private let healthStore = HKHealthStore()
    @Published var steps: Double = 0
    @Published var totalCalories: Double = 0
    static let shared: HealthkitManager = HealthkitManager()
    private var anchor: HKQueryAnchor?
    private enum Errors: Error {
        case defaultError
    }
    let calendar = Calendar(identifier: .gregorian)
    
    private init() {
        requestHealthkitPermissions()
    }
    
    private func requestHealthkitPermissions() {
        
        let sampleTypesToRead = Set([
            HKObjectType.activitySummaryType(),
            HKObjectType.workoutType(),
        ])
        Task {
            try await healthStore.requestAuthorization(toShare: Set([]), read: sampleTypesToRead)
        }
    }
    
    // Fetch total calories (active + basal) burned for the current day
    func fetchCaloriesBurned() async throws {
        guard HKHealthStore.isHealthDataAvailable() else { throw Errors.defaultError }
        // Get the start and end date components.
        let calendar = Calendar(identifier: .gregorian)


        var startComponents = calendar.dateComponents([.day, .month, .year], from: Date())
        startComponents.calendar = calendar
    
        var endComponents = startComponents
        endComponents.calendar = calendar
        endComponents.day = 1 + (endComponents.day ?? 0)

        // Create a predicate for the query.
        let today = HKQuery.predicate(forActivitySummariesBetweenStart: startComponents, end: startComponents)
        // Create the descriptor.
        let activeSummaryDescriptor = HKActivitySummaryQueryDescriptor(predicate:today)
        
        // Run the query.
      
        let results = try await activeSummaryDescriptor.result(for: healthStore)
        print(results.first?.activeEnergyBurned)
        
    }
}
