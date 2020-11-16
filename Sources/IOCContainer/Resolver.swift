//
//  Resolver.swift
//  IOCContainer
//
//  Created by Mirek Petricek on 15/11/2020.
//  Copyright © 2020 Dependency Injection Limited. All rights reserved.
//

import Foundation

public protocol Resolver {
    func resolve<T>(_ type: T.Type) throws -> T
}
