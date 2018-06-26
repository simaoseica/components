import UIKit

final public class ConcreteViewController: UIViewController {

    fileprivate let dataSource = DataSource()
    fileprivate let presenter: Presenter

    public init() {

        let component = ConcreteComponent()
        component.delegate = self.dataSource

        self.presenter = Presenter(component: component)
        self.dataSource.delegate = presenter

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func loadView() {

        self.view = self.presenter.component
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        self.presenter.updateComponent()
    }
}
