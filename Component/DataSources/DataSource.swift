import Foundation

protocol DataSourceDeletage: class {

    func has(newConfiguration: ConcreteComponent.Configuration, in dataSource: DataSource)
}

final public class DataSource {

    weak var delegate: DataSourceDeletage?

}

extension DataSource: ConcreteComponentDelegate {

    func didTapButton(with currentConfiguration: ConcreteComponent.Configuration, in component: ConcreteComponent) {

        switch currentConfiguration {
        case .male:

            self.delegate?.has(newConfiguration: .female("skirt.jpg", "Skirt"), in: self)
        case .female:

            self.delegate?.has(newConfiguration: .male("shorts.jpeg", "Shorts"), in: self)
        }
    }
}
