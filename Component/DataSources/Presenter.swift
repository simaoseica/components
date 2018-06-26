//
//  Presenter.swift
//  Component
//
//  Created by Simão Seiça  on 25/06/2018.
//

final public class Presenter {

    private var dataSource: DataSource
    var component: ConcreteComponent

    init(component: ConcreteComponent = ConcreteComponent(),
         dataSource: DataSource = DataSource()) {

        self.component = component
        self.dataSource = dataSource
        
        self.component.delegate = self
        self.dataSource.delegate = self
    }

    func updateUI() {

        self.component.render(with: .female(#imageLiteral(resourceName: "skirt.jpg"), "Skirt"))
    }
}

extension Presenter: ConcreteComponentDelegate {

    func didTapButton(with currentConfiguration: ConcreteComponent.Configuration, in component: ConcreteComponent) {

        self.dataSource.requestNextConfiguration(after: currentConfiguration)
    }
}

extension Presenter: DataSourceDeletage {

    func has(newConfiguration: ConcreteComponent.Configuration, in dataSource: DataSource) {

        self.component.render(with: newConfiguration)
    }
}
