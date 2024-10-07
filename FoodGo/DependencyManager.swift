//
//  DependencyManager.swift
//  FoodGo
//
//  Created by Alex.personal on 7/10/24.
//

import Foundation

/// A class that manages dependency registration and resolution in a thread-safe and type-safe way.
/// The `DependencyManager` is implemented as an `actor` for automatic thread-safety.
/// It allows registering dependencies and resolving them dynamically during runtime.
public actor DependencyManager {
    
    /// Errors that can occur during dependency management.
    enum DependencyManagerError: Error {
        /// Error thrown when a dependency cannot be found for the requested type.
        case notFound
        /// Error thrown when a dependency of a certain type is already registered.
        case typeAlreadyRegistered
    }

    /// Shared singleton instance of `DependencyManager` for global access.
    public static let shared = DependencyManager()
    
    /// Internal storage for the registered dependencies.
    /// The keys are `String` representations of the dependency types, and the values are the dependencies.
    private var dependencies: [String: Any] = [:]
    
    /// Private initializer to ensure the class is only instantiated via the singleton `shared` instance.
    private init() {}

    /// Registers a dependency with the manager.
    ///
    /// - Parameters:
    ///   - dependency: The type of the dependency to register.
    ///   - completion: A closure that provides the instance of the dependency when invoked.
    /// - Throws: `DependencyManagerError.typeAlreadyRegistered` if a dependency of the given type is already registered.
    ///
    /// This method allows you to dynamically register a dependency of type `T`.
    func register<T>(_ dependency: T.Type, completion: @escaping () -> T) throws  {
        let key = String(describing: dependency.self)
        
        // Check if the type is already registered
        guard !dependencies.contains(where: { $0.key == key }) else {
            throw DependencyManagerError.typeAlreadyRegistered
        }
        
        // Register the dependency
        dependencies[key] = completion()
    }
    
    /// Resolves and retrieves a registered dependency by its type.
    ///
    /// - Parameter dependency: The type of the dependency to resolve.
    /// - Returns: The instance of the registered dependency.
    /// - Throws: `DependencyManagerError.notFound` if no dependency of the given type is found.
    ///
    /// Use this method to retrieve a dependency by providing its type.
    /// Example:
    /// ```
    /// let myService: MyService = try DependencyManager.shared.resolve(MyService.self)
    /// ```
    func resolve<T>(_ dependency: T.Type) throws -> T {
        let key = String(describing: dependency.self)
        
        // Try to resolve and cast the dependency to the requested type
        guard let dependency = dependencies[key] as? T else {
            throw DependencyManagerError.notFound
        }
        
        return dependency
    }
}

