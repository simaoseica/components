//
//  Presenter.swift
//  Component
//
//  Created by Simão Seiça  on 26/06/2018.
//

public final class Presenter {

    let component: ConcreteComponent

    init(component: ConcreteComponent = ConcreteComponent()) {

        self.component = component
    }

    func updateComponent() {

        self.component.render(with: .female("skirt.jpg", "Skirt"))
    }
}

extension Presenter {

    public enum Configuration {
        case male(String, String)
        case female(String, String)
    }
}

extension Presenter: DataSourceDeletage {

    func has(newConfiguration: ConcreteComponent.Configuration, in dataSource: DataSource) {

        self.component.render(with: newConfiguration)
    }
}
