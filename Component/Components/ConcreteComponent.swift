import UIKit

protocol ConcreteComponentDelegate: class {

    func didTapButton(with currentConfiguration: ConcreteComponent.Configuration, in component: ConcreteComponent)
}

public final class ConcreteComponent: UIView {

    fileprivate let myLabel: UILabel = {

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    fileprivate let myImageView: UIImageView = {

        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        
        image.translatesAutoresizingMaskIntoConstraints = false

        return image
    }()

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

        self.delegate?.didTapButton(with: self.model!, in: self)
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
            self.myLabel.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor, constant: 20),
            self.myLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -20),
            self.myLabel.bottomAnchor.constraint(equalTo: self.myImageView.topAnchor, constant: -20),
            self.myLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),

            self.myImageView.bottomAnchor.constraint(lessThanOrEqualTo: self.myButton.topAnchor, constant: -20),
            self.myImageView.widthAnchor.constraint(equalToConstant: 200),
            self.myImageView.heightAnchor.constraint(equalToConstant: 200),
            self.myImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),

            self.myButton.widthAnchor.constraint(equalToConstant: 100),
            self.myButton.heightAnchor.constraint(equalToConstant: 50),
            self.myButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.myButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)])
    }
}

extension ConcreteComponent: Component {

    public enum Configuration {
        case male(UIImage, String)
        case female(UIImage, String)
    }

    public func render(with configuration: Configuration) {

        self.model = configuration

        switch configuration {
        case let .male(image, title):

            self.myLabel.text = title
            self.myButton.backgroundColor = .pink
            self.myImageView.image = image
            self.backgroundColor = .blue
        case let .female(image, title):

            self.myLabel.text = title
            self.myButton.backgroundColor = .blue
            self.myImageView.image = image
            self.backgroundColor = .pink
        }
    }
}

private extension UIColor {

    static let pink: UIColor = UIColor(hex: 0xFF69B4)
    static let blue: UIColor = UIColor(hex: 0x1E90FF)
}

