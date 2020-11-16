//
//  IOCContainerTests.swift
//  IOCContainerTests
//
//  Created by Mirek Petricek on 15/11/2020.
//  Copyright © 2020 Dependency Injection Limited. All rights reserved.
//

import XCTest
@testable import IOCContainer

class SimpleTestClass1 {}
class SimpleTestClass2 {}


// Class A which has dependency on Class B
class ClassA {
    let typeB: ClassB
    init(typeB: ClassB) {
        self.typeB = typeB
    }
}

// Class B which has dependency on Class A
class ClassB {
    let typeA: ClassA
    init(typeA: ClassA) {
        self.typeA = typeA
    }
}

// Class C which has dependency on SimpleTestClass1
class ClassC {
    let simpleTestClass1: SimpleTestClass1
    init(simpleTestClass1: SimpleTestClass1) {
        self.simpleTestClass1 = simpleTestClass1
    }
}


class IOCContainerTests: XCTestCase {
    
    var container: Container!

    override func setUpWithError() throws {
        try super.setUpWithError()
        container = Container()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func test_Resolve_canRegisterSimpleTypes() throws {
        container.register(SimpleTestClass1.self) { _ -> Any in
            SimpleTestClass1()
        }
        XCTAssertNoThrow(try container.resolve(SimpleTestClass1.self))
    }
    
    func test_Resolve_throwsErrorForUnregisteredType() throws {
        XCTAssertThrowsError(try container.resolve(SimpleTestClass2.self))
    }
    
    func test_Remove_unregistersType() throws {
        container.register(SimpleTestClass1.self) { _ -> Any in
            SimpleTestClass1()
        }
        XCTAssertNoThrow(try container.resolve(SimpleTestClass1.self))
        container.remove(SimpleTestClass1.self)
        XCTAssertThrowsError(try container.resolve(SimpleTestClass1.self))
    }
    
    func test_Resolve_resolvesTypeWithDependency() {
        container.register(SimpleTestClass1.self) { _ -> Any in
            return SimpleTestClass1()
        }
        
        container.register(ClassC.self) { resolver -> Any in
             let simpleTestClass1 = try resolver.resolve(SimpleTestClass1.self)
             return ClassC(simpleTestClass1: simpleTestClass1)
         }

        XCTAssertNoThrow(try container.resolve(ClassC.self))
    }
    
    func test_Resolve_throwsErroWhenUnresolvableDependency() {
        container.register(ClassA.self) { resolver -> Any in
            let typeB = try resolver.resolve(ClassB.self)
            return ClassA(typeB: typeB)
        }

        XCTAssertThrowsError(try container.resolve(ClassA.self))
    }
}
