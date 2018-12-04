# ToastCollectionView

[![CIStatus](https://img.shields.io/travis/scaraux/ToastCollectionViewCell.svg?style=flat)](https://travis-ci.org/scaraux/ToastCollectionViewCell)
[![Version](https://img.shields.io/cocoapods/v/ToastCollectionView.svg?style=flat)](https://cocoapods.org/pods/ToastCollectionView)
[![License](https://img.shields.io/cocoapods/l/ToastCollectionView.svg?style=flat)](https://cocoapods.org/pods/ToastCollectionView)
[![Platform](https://img.shields.io/cocoapods/p/ToastCollectionView.svg?style=flat)](https://cocoapods.org/pods/ToastCollectionView)
[![Swift 4          support](https://img.shields.io/badge/Swift-4-orange.svg?style=flat)](https://cocoapods.org/pods/ToastCollectionView)

## :star: What does it do ?

ToastCollectionView is a Swift `UICollectionView` that pushes and displays views when scrolling, reminding of a toast popping out of a toaster 🍞

It is useful is you wish to display information about the content of your cells

<p align="center">
    <img src="Artwork/example.gif" width="250" alt="Example Toast Collection View"/>
</p>

##  📲 Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## 📋 Requirements

ToastCollectionView requires iOS 9 and Swift 4

##  📦 Installation

ToastCollectionView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ToastCollectionView'
```

## 😏 Usage

### 1. Create yourself a 'Toast' view that your cells will display upon scrolling

Create a class that inherits from the `UIView` class, with the shape and design you want...

```swift
class MyToastView: UIView {
    // Your code here
}
```

### 2. Create your ToastCollectionView replacing your current UICollectionView

1. Instantiate a `ToastCollectionView`

2. Implement the `datasource` and `delegate`

#### Set the Toast view offsets :

- `maxPositionForComponent` is how high you want your toast to go when scrolling

- `offsetToComponent` is the offset between the `CollectionView` and each toast for triggering movements

#### Example:

```swift
class ViewController: UIViewController {

	var collectionView: ToastCollectionView?

	override func viewDidLoad() {
		super.viewDidLoad()

		// Instanciate the CollectionView
		let collectionViewLayout = UICollectionViewLayout()
		self.collectionView = ToastCollectionView(frame: CGRect, collectionViewLayout: collectionViewLayout)

		// Set the offsets
		self.collectionView.maxPositionForComponent = 75.0
		self.collectionView.offsetToComponent = 30.0

		// Set the delegates
		self.collectionView.delegate = self
		self.collectionView.dataSource = self
	}
}
```

### 3. Create a UICollectionviewCell that inherits from ToastCollectionViewCell

Override the `toastViewForCell()` method, and return your Toast view

```swift
override func toastViewForCell() -> UIView? {
    // Return the Toast view with the size you want
    return MyToastView(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
}
```

If you wish to expand the toast view when it has reach the maximum vertical position, override the `widthForExpandedToastView()` method and return the new width

```swift
override func widthForExpandedToastView() -> CGFloat? {
    return 190.0
}
```

### Extras

The `ToastCollectionViewCell` offers a `preRaiseToastView(toPosition: CGFloat)` method that allows you to force some Toast views to be risen. It's useful for example for the first cells that appears when you present the CollectionView, so they don't pop only when the user starts to scroll.


### Delegation

By implementing the `ToastCollectionViewCellDelegate`, you can be notified when any of your Toast views get to
their top position, meaning they are fully raised.

You can then trigger an action on the given Toast view.

#### Example:

```Swift
class ExampleCell: ToastCollectionViewCell, ToastCollectionViewCellDelegate {
	func onToastFullyRaised(toast: UIView) {
		let toast = toast as! MyToastView
		toast.doSomething()
	}
}
```

## 👱 Author

Oscar Gotting ([@Scaraux](https://twitter.com/scaraux))

## 🚔 License

ToastCollectionViewCell is available under the MIT license. See the LICENSE file for more info.
