//
//  SecondaryService.swift
//  IOContainerExample
//
//  Created by Mirek Petricek on 16/11/2020.
//  Copyright © 2020 Dependency Injection Limited. All rights reserved.
//

import Foundation

class SecondaryService: SecondaryServiceProtocol {
    var didSomething = false
    func doSomething() {
        didSomething = true
    }
}
