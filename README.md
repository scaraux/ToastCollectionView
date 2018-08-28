# ToastCollectionViewCell

[![CI Status](https://img.shields.io/travis/gottingoscar@gmail.com/ToastCollectionViewCell.svg?style=flat)](https://travis-ci.org/gottingoscar@gmail.com/ToastCollectionViewCell)
[![Version](https://img.shields.io/cocoapods/v/ToastCollectionViewCell.svg?style=flat)](https://cocoapods.org/pods/ToastCollectionViewCell)
[![License](https://img.shields.io/cocoapods/l/ToastCollectionViewCell.svg?style=flat)](https://cocoapods.org/pods/ToastCollectionViewCell)
[![Platform](https://img.shields.io/cocoapods/p/ToastCollectionViewCell.svg?style=flat)](https://cocoapods.org/pods/ToastCollectionViewCell)

## :star: What does it do ?

ToastCollectionViewCell is a Swift CollectionViewCell that displays a view when scrolling, reminding of a toast popping out of a toaster 🍞

<p align="center">
    <img src="Artwork/example.gif" width="250" alt="Example Toast Collection View"/>
</p>

##  📲 Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## 📋 Requirements

ToastCollectionViewCell requires iOS 9 and Swift 4

##  📦 Installation

ToastCollectionViewCell is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ToastCollectionViewCell', :git => 'https://github.com/frenchfalcon/ToastCollectionViewCell'
```

## 😏 Usage

### 1. Create yourself a 'Toast' view that your cells will display upon scrolling

Create a class that inherits from the `UIView` class, with the shape and design you want...

```swift
class MyToast: UIView {
	// Your code, your design
}
```

### 2. Create your UICollectionView like you would normally do

1. Instantiate a classic `UICollectionView`

2. Instantiate a `ToastCollectionViewCellDelegate`  **delegate**
	***Important:*** It has to be declared as a class property

5. This `delegate` needs a reference to your `UICollectionView`, pass it the view!

6. Finally, set the `delegate` property of your `UICollectionView`, to this delegate

#### It is possible to decided of the toast view offsets :

- `maxPositionForComponent` is how high you want your toast to go when scrolling

- `offsetToComponent` is the offset between the `UICollectionView` and each toast for triggering movements

#### Example:

```swift
class ViewController: UIViewController {

	var toastDelegate: ToastCollectionViewDelegate() // Class property
	var collectionView: UICollectionView?

	override func viewDidLoad() {
		super.viewDidLoad()

		// Instanciate the UICollectionView
		let collectionViewLayout = UICollectionViewLayout()
		self.collectionView = UICollectionView(frame: CGRect, collectionViewLayout: 		collectionViewLayout)

		// Set the offsets
		self.toastDelegate.maxPositionForComponent = 75.0
		self.toastDelegate.offsetToComponent = 20.0

		// Pass the UICollectionView to the delegate
		self.toastDelegate.collectionView = self.collectionView!

		// Set the delegates
		self.collectionView!.delegate = self.toastDelegate
		self.collectionView!.dataSource = self // Implement your methods
	}
}
```

### 3. Create a UICollectionviewCell that inherits from ToastCollectionViewCell

Override the `toastViewForCell()` method, and return your Toast view

```swift
override func toastViewForCell() -> UIView? {
	// Return the ToastView with the size you want
	return MyToastView(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
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

Oscar Gotting, gottingoscar@gmail.com

## 🚔 License

ToastCollectionViewCell is available under the MIT license. See the LICENSE file for more info.
