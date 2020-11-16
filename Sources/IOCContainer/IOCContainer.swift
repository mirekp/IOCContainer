//
//  IOCContainer.swift
//  IOCContainer
//
//  Created by Mirek Petricek on 15/11/2020.
//  Copyright © 2020 Dependency Injection Limited. All rights reserved.
//

import Foundation

public final class Container: Resolver {
    
    public typealias FactoryClosure = (Resolver) throws -> Any

    public enum Errors: Error {
        case typeNotRegistered
        case typeCannotBeInstantiated
    }
    
    private var registrations: [AnyHashable : FactoryClosure]
    
    public init() {
        registrations = [AnyHashable : FactoryClosure]()
    }
    
    /// Registers constructor of the specified type.
    ///
    /// - Parameters
    ///             type: Type to be registered
    ///      constructor: The constructor used to create an instance of a given type.
    ///
    /// - Returns: N/A
    public func register<T>(_: T.Type, constructor: @escaping FactoryClosure) {
        let dependencyName = String(reflecting: T.self)
        registrations[dependencyName] = constructor
    }
        
    /// Retrieves the instance of the specified type.
    ///
    /// - Parameter type: The service type to resolve (can be inferred).
    ///
    /// - Returns: The resolved service type instance, throws if no service is found.
    public func resolve<T>(_ type: T.Type = T.self) throws -> T {
        let dependencyName = String(reflecting: T.self)
        guard let resolver = registrations[dependencyName] else {
            throw(Errors.typeNotRegistered)
        }
        guard let resolvedInstance = try? resolver(self) as? T else {
            throw(Errors.typeCannotBeInstantiated)
        }
        return resolvedInstance
    }
    
    
    /// Unregisters the ype.
    ///
    /// - Parameter type: The service type to remove.
    ///
    /// - Returns: N/A
    public func remove<T>(_ type: T.Type) {
        let dependencyName = String(reflecting: T.self)
        registrations.removeValue(forKey: dependencyName)
    }
}
