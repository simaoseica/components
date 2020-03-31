import Foundation

public protocol Component: class {

    associatedtype State

    func render(with configuration: State)
}
