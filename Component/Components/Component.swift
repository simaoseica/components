import Foundation

public protocol Component: class {

    associatedtype Configuration

    func render(with configuration: Configuration)
}
