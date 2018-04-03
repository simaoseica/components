import UIKit

protocol ConcreteComponentDelegate: class {

    func didTap(button: UIButton, in component: ConcreteComponent)
}

public final class ConcreteComponent: UIView {

    fileprivate let myLabel: UILabel = UILabel()
    fileprivate let myImageView: UIImageView = UIImageView()

    fileprivate let myButton: UIButton = {

        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(performAction(sender:)), for: .touchUpInside)
        button.setTitle("TAP ME", for: .normal)

        return button
    }()

    fileprivate (set) var model: Configuration?

    weak var delegate: ConcreteComponentDelegate?

    public init() {

        super.init(frame: .zero)
        self.defineSubviews()
        self.defineSubviewsConstraints()
    }

    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc
    func performAction(sender: UIButton) {

        self.delegate?.didTap(button: sender, in: self)
    }
}

fileprivate extension ConcreteComponent {

    func defineSubviews() {

        self.addSubview(self.myLabel)
        self.addSubview(self.myImageView)
        self.addSubview(self.myButton)
    }

    func defineSubviewsConstraints() {

        NSLayoutConstraint.activate([

            self.myLabel.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor),
            self.myLabel.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor),
            self.myLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor),
            self.myLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor),


            self.myButton.widthAnchor.constraint(equalToConstant: 100),
            self.myButton.heightAnchor.constraint(equalToConstant: 50),
            self.myButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.myButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)])
    }
}

extension ConcreteComponent: Component {

    public enum Configuration {
        case state1
        case state2
    }

    public func render(with configuration: Configuration) {

        self.model = configuration

        switch configuration {
        case .state1:

            self.myButton.backgroundColor = .blue
            self.backgroundColor = .green
        case .state2:

            self.myButton.backgroundColor = .green
            self.backgroundColor = .blue
        }
    }
}
