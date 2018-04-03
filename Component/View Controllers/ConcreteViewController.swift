import UIKit

final public class ConcreteViewController: UIViewController {

    fileprivate let component = ConcreteComponent()

    fileprivate let dataSource = DataSource()

    public init() {

        super.init(nibName: nil, bundle: nil)
        self.component.delegate = self
        // self.dataSource.delegate = self
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

        self.component.render(with: .female(#imageLiteral(resourceName: "skirt.jpg"), "Skirt"))
    }
}

extension ConcreteViewController: ConcreteComponentDelegate {

    func didTap(button: UIButton, in component: ConcreteComponent) {

        switch component.model! {
        case .male:

            self.component.render(with: .female(#imageLiteral(resourceName: "skirt.jpg"), "Skirt"))
        case .female:

            self.component.render(with: .male(#imageLiteral(resourceName: "shorts.jpeg"), "Shorts"))
        }
    }
}
