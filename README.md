# IOCContainer


IOCContainer is a simple container for Swift to make Dependency Injection easier.

It helps your app split into loosely-coupled components, which can be developed, tested and maintained more easily.

## Requirements

- Swift 5.0+
- Xcode 11.7+

## Installation

### Swift Package Manager

in `Package.swift` add the following:

```swift
dependencies: [
    .package(url: "https://github.com/mirekp/IOCContainer/IOCContainer.git", from: "1.0.0")
],
targets: [
    .target(
        name: "MyProject",
        dependencies: [..., "IOCContainer"]
    )
    ...
]
```

## Basic Usage

First, register a class creation closures to  a `Container` class.  This class acts as a factory that can create different type of instances used in the app. In this example, `Car`   and `VehicleOwner` are component classes implementing `Vehicle` and `Person` protocols respectively.

```swift
let container = Container()
container.register(Vehicle.self) { _ in Car(type: "Mercedes") }
container.register(Person.self) { resolver in
    let vehicle = try resolver.resolve(Vehicle.self)
    return VehicleOwner(vehicle: vehicle)
}
```

Where definitions of the protocols and classes are

```swift
protocol Vehicle {
    var type: String { get }
}

class Car: Vehicle {
    let type: String

    init(type: String) {
        self.type = type
    }
}
```

and

```swift
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
```

Then get an instance of a service from the container. The person is resolved to a car owner, and prints that it is driving a Mercedes car:

```swift
let person = try! container.resolve(Person.self)
person.drive() // prints "Driving Mercedes."
```


## Example App

The repo includes  IOSContainerExample which demostrates using the library in a simple project including use in unit tests.


