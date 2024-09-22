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
    
    func basalEnergy() {
        // Define the basal energy burned type
        guard let basalEnergyBurnedType = HKQuantityType.quantityType(forIdentifier: .basalEnergyBurned) else {
            fatalError("Unable to get basal energy burned type")
        }
        
        // Define the date range (e.g., for today)
        let calendar = Calendar.current
        let startDate = calendar.startOfDay(for: Date())
        let endDate = calendar.date(byAdding: .day, value: 1, to: startDate)
        
        // Create a predicate for the date range
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
        
        // Create the statistics query to sum the basal energy burned
        let query = HKStatisticsQuery(quantityType: basalEnergyBurnedType, quantitySamplePredicate: predicate, options: .cumulativeSum) { query, result, error in
            if let error = error {
                print("Error fetching basal energy: \(error.localizedDescription)")
                return
            }
            
            if let sumQuantity = result?.sumQuantity() {
                let totalCalories = sumQuantity.doubleValue(for: HKUnit.kilocalorie())
                print("Total basal calories burned today: \(totalCalories)")
            } else {
                print("No basal energy burned data available")
            }
        }
        
        healthStore.execute(query)
    }
}
