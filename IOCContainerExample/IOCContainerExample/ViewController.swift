//
//  ViewController.swift
//  IOCContainerExample
//
//  Created by Mirek Petricek on 16/11/2020.
//  Copyright © 2020 Dependency Injection Limited. All rights reserved.
//

import UIKit
import IOCContainer

class ViewController: UIViewController {
    
    var container = Container()

    override func viewDidLoad() {
        super.viewDidLoad()
        container.register(PrimaryService.self) { [unowned self] _ -> Any in
            PrimaryService(container: self.container)
        }
        let service = try! container.resolve(PrimaryService.self)
        service.start()
    }
}

