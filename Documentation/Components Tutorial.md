# Components Tutorial

1. Add states to `ConcreteComponent` class:

```swift
public enum Configuration {
    case male(UIImage, String)
    case female(UIImage, String)
}
```

2. Save state in the `ConcreteComponent` class:

```swift
self.model = configuration
```

3. Add Presentation logic to `ConcreteComponent` class:

```swift
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
```

4. Set the component in the `ViewController` view:

```swift
self.view = self.component
```

5. Set the `Component` delegate in the `init`:

```swift
self.component.delegate = self
```

6. Render initial state in `ConcreteViewController` class:

```swift
self.component.render(with: .female(#imageLiteral(resourceName: "skirt.jpg"), "Skirt"))
```

7. Set the `DataSource` delegate in the `init`:

```swift
self.dataSource.delegate = self
```

8. Request new state to the `DataSource`:

```swift
self.dataSource.requestNextConfiguration(after: currentConfiguration)
```

9. Add business logic to `DataSource`:

```swift

switch currentConfiguration {
case .male:

self.delegate?.has(newConfiguration: .female(#imageLiteral(resourceName: "skirt.jpg"), "Skirt"), in: self)
case .female:

self.delegate?.has(newConfiguration: .male(#imageLiteral(resourceName: "shorts.jpeg"), "Shorts"), in: self)
}
```

10. Render the new state on the component:

```swift
self.component.render(with: newConfiguration)
```
