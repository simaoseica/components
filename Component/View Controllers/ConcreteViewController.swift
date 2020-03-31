import UIKit

final public class ConcreteViewController: UIViewController {

    fileprivate let component = ConcreteComponent()

    fileprivate let dataSource = DataSource()

    public init() {

        super.init(nibName: nil, bundle: nil)
        self.component.delegate = self
        self.dataSource.delegate = self
    }

    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func loadView() {

        self.view = self.component
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        self.component.render(with: .female("skirt.jpg", "Skirt"))
    }
}

extension ConcreteViewController: ConcreteComponentDelegate {

    func didTapButton(with currentConfiguration: ConcreteComponent.State, in component: ConcreteComponent) {

        self.dataSource.requestNextConfiguration(after: currentConfiguration)
    }
}

extension ConcreteViewController: DataSourceDeletage {

    func has(newConfiguration: ConcreteComponent.State, in dataSource: DataSource) {

        self.component.render(with: newConfiguration)
    }
}
