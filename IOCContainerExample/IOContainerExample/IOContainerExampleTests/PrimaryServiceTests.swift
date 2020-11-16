//
//  PrimaryServiceTests.swift
//  IOContainerExampleTests
//
//  Created by Mirek Petricek on 16/11/2020.
//  Copyright © 2020 Dependency Injection Limited. All rights reserved.
//

import XCTest
import IOCContainer
@testable import IOContainerExample

class MockService: SecondaryServiceProtocol {
    var doSomethingCallCount = 0
    func doSomething() {
        doSomethingCallCount += 1
    }
}

class PrimaryServiceTests: XCTestCase {
    
    var mockContainer: Container!
    var service: PrimaryService!
    var mockService: MockService!

    override func setUpWithError() throws {
        mockService = MockService()
        mockContainer = Container()
        service = PrimaryService(container: mockContainer)
        mockContainer.register(SecondaryServiceProtocol.self) { _ -> Any in
            self.mockService!
        }
    }

    func testStart_callsIntoService() throws {
        service.start()
        XCTAssertEqual(mockService.doSomethingCallCount, 1)
    }
}

protocol Vehicle {
    var type: String { get }
}

class Car: Vehicle {
    let type: String

    init(type: String) {
        self.type = type
    }
}


protocol Person {
    func drive()
}

class VehicleOwner: Person {
    let vehicle: Vehicle

    init(vehicle: Vehicle) {
        self.vehicle = vehicle
    }

    func drive() {
        print("Driving \(vehicle.type).")
    }
}

func test() {

let container = Container()
container.register(Vehicle.self) { _ in Car(type: "Mercedes") }
container.register(Person.self) { resolver in
    let vehicle = try! resolver.resolve(Vehicle.self)
    return VehicleOwner(vehicle: vehicle)
}

let person = try! container.resolve(Person.self)
person.drive() // prints "Driving Mercedes."

