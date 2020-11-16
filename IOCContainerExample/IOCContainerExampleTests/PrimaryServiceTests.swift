//
//  PrimaryServiceTests.swift
//  IOCContainerExampleTests
//
//  Created by Mirek Petricek on 16/11/2020.
//  Copyright © 2020 Dependency Injection Limited. All rights reserved.
//

import XCTest
import IOCContainer
@testable import IOCContainerExample

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
