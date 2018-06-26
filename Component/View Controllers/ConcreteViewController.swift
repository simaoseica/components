import UIKit

final public class ConcreteViewController: UIViewController {

    fileprivate let presenter = Presenter()

    public init() {

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

        self.presenter.updateUI()
    }
}
