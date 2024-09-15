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
    
    private init() {
        requestHealthkitPermissions()
    }
    
    private func requestHealthkitPermissions() {
        
        let sampleTypesToRead = Set([
            HKObjectType.quantityType(forIdentifier: .stepCount)!,
            HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
            HKObjectType.quantityType(forIdentifier: .basalEnergyBurned)!
        ])
        
        healthStore.requestAuthorization(toShare: nil, read: sampleTypesToRead) { (success, error) in
            print("Request Authorization -- Success: ", success, " Error: ", error ?? "nil")
        }
    }
    
    func fetchStepCount() {
           let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount)!

           let startOfDay = Calendar.current.startOfDay(for: Date())
           let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: Date(), options: .strictStartDate)

           let query = HKStatisticsQuery(quantityType: stepType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, error in
               guard let result = result, let sum = result.sumQuantity() else {
                   // Handle error here
                   print("Failed to fetch steps")
                   return
               }

               DispatchQueue.main.async {
                   self.steps = sum.doubleValue(for: HKUnit.count())
               }
           }

           healthStore.execute(query)
       }
    
    // Fetch total calories (active + basal) burned for the current day
        func fetchCaloriesBurned() {
            let activeEnergyType = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!
            let basalEnergyType = HKQuantityType.quantityType(forIdentifier: .basalEnergyBurned)!

            let startOfDay = Calendar.current.startOfDay(for: Date())
            let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: Date(), options: .strictStartDate)
            
            

            // Query Active Energy
            let activeEnergyQuery = HKStatisticsQuery(quantityType: activeEnergyType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, error in
                guard let result = result, let activeEnergy = result.sumQuantity() else {
                    print("Error fetching active energy: \(String(describing: error))")
                    return
                }

                let activeCalories = activeEnergy.doubleValue(for: HKUnit.kilocalorie())

                // Query Basal Energy
                let basalEnergyQuery = HKStatisticsQuery(quantityType: basalEnergyType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, error in
                    guard let result = result, let basalEnergy = result.sumQuantity() else {
                        print("Error fetching basal energy: \(String(describing: error))")
                        return
                    }

                    let basalCalories = basalEnergy.doubleValue(for: HKUnit.kilocalorie())

                    // Calculate total calories (active + basal)
                    DispatchQueue.main.async {
                        self.totalCalories = activeCalories + basalCalories
                    }
                }

                self.healthStore.execute(basalEnergyQuery)
            }

            self.healthStore.execute(activeEnergyQuery)
        }
}
