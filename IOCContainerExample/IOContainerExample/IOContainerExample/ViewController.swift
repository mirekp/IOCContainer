//
//  ViewController.swift
//  IOContainerExample
//
//  Created by Mirek Petricek on 16/11/2020.
//  Copyright © 2020 Dependency Injection Limited. All rights reserved.
//

import UIKit
import IOCContainer

class MyService {
    var realDoSomethingCalled = false
    
    func doSomething() {
        realDoSomethingCalled = true
    }
}

class ViewController: UIViewController {
    
    var container = Container()
    var service: MyService?

    override func viewDidLoad() {
        super.viewDidLoad()
        container.register(MyService.self) { _ -> Any in
            MyService()
        }
        service = try? container.resolve()
    }
}

