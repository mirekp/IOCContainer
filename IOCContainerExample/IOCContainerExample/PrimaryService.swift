//
//  PrimaryService.swift
//  IOCContainerExample
//
//  Created by Mirek Petricek on 16/11/2020.
//  Copyright © 2020 Dependency Injection Limited. All rights reserved.
//

import Foundation
import IOCContainer

protocol SecondaryServiceProtocol {
     func doSomething()
}

class PrimaryService {
    let container: Container
    lazy var service: SecondaryServiceProtocol? = {
       return try? container.resolve(SecondaryServiceProtocol.self)
    }()
    
    init(container: Container) {
        self.container = container
        container.register(SecondaryServiceProtocol.self, constructor: { _ -> Any in
            SecondaryService()
        })
    }
    
    func start() {
        print("PrimaryService start() called")
        service?.doSomething()
    }
}
