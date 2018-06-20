import Foundation

protocol DataSourceDeletage: class {

    func has(newConfiguration: ConcreteComponent.State, in dataSource: DataSource)
}

final public class DataSource {

    weak var delegate: DataSourceDeletage?

    func requestNextConfiguration(after currentConfiguration: ConcreteComponent.State){

        switch currentConfiguration {
        case .male:

            self.delegate?.has(newConfiguration: .female("skirt.jpg", "Skirt"), in: self)
        case .female:

            self.delegate?.has(newConfiguration: .male("shorts.jpeg", "Shorts"), in: self)
        }
    }
}
