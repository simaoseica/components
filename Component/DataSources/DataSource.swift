import Foundation

protocol DataSourceDeletage: class {

    func has(newConfiguration: ConcreteComponent.Configuration, in dataSource: DataSource)
}

final public class DataSource {

    weak var delegate: DataSourceDeletage?

    func requestNextConfiguration(after currentConfiguration: ConcreteComponent.Configuration){

        switch currentConfiguration {
        case .male:

            self.delegate?.has(newConfiguration: .female(#imageLiteral(resourceName: "skirt.jpg"), "Skirt"), in: self)
        case .female:

            self.delegate?.has(newConfiguration: .male(#imageLiteral(resourceName: "shorts.jpeg"), "Shorts"), in: self)
        }
    }
}
