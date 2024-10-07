//
//  FoodGoTests.swift
//  FoodGoTests
//
//  Created by Alex.personal on 14/8/24.
//

import XCTest
@testable import FoodGo

final class FoodGoTests: XCTestCase {

    func test_DI() async throws {
        let di = DependencyManager.shared
        try await di.register(TestProtocol.self) {
            TestDIClass(number: 1)
        }
        
        let type = try await di.resolve(TestProtocol.self)
        XCTAssertNotNil(type)
    }
}

protocol TestProtocol {
    func doSomething()
}

class TestDIClass: TestProtocol {
    func doSomething() {
        
    }
    
    let number: Int
    
    init(number: Int) {
        self.number = number
    }
}
