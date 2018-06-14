# ToastCollectionViewCell

[![CI Status](https://img.shields.io/travis/gottingoscar@gmail.com/ToastCollectionViewCell.svg?style=flat)](https://travis-ci.org/gottingoscar@gmail.com/ToastCollectionViewCell)
[![Version](https://img.shields.io/cocoapods/v/ToastCollectionViewCell.svg?style=flat)](https://cocoapods.org/pods/ToastCollectionViewCell)
[![License](https://img.shields.io/cocoapods/l/ToastCollectionViewCell.svg?style=flat)](https://cocoapods.org/pods/ToastCollectionViewCell)
[![Platform](https://img.shields.io/cocoapods/p/ToastCollectionViewCell.svg?style=flat)](https://cocoapods.org/pods/ToastCollectionViewCell)

ToastCollectionViewCell is a Swift library that displays an animated toast controlled by the scroll, appearing in your UICollectionViewCells

## :star: What does it do ?

ToastCollectionViewCell is a Swift library that displays an animated toast controlled by the scroll, appearing in your UICollectionViewCells

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

1. Instantiate a classic `UICollectionView`,
2. Set its `datasource` delegate and implement the `cellForItemAt` , `numberOfItemsInSection` methods
3. Instantiate a `ToastCollectionViewCellDelegate` as a **class property**
4. Set the `componentMaximumHeightPosition` and `offsetToComponent` values
5. Set the `collectionView` to your actual collectionView
6. Finally, set your `UICollectionView` **delegate** to this class variable you created

The `componentMaximumViewHeightPosition` refers to the maximum position you want your toast raised when fully visible.
The `offsetToComponent`is an offset used to trigger the toast movement when scrolling. This offset is between the toast view and the `UICollectionView`.

#### Example:

```swift
class ViewController: UIViewController {

	var toastDelegate: ToastCollectionViewDelegate()
	var collectionView: UICollectionView?

	override func viewDidLoad() {
		super.viewDidLoad()

		let collectionViewLayout = UICollectionViewLayout()
		self.collectionView = UICollectionView(frame: CGRect, collectionViewLayout: 		collectionViewLayout)

		self.toastDelegate.collectionView = self.collectionView!
		self.toastDelegate.componentMaximumHeightPosition = 75.0
		self.toastDelegate.offsetToComponent = 20.0

		self.collectionView!.dataSource = self // Implement your methods
		self.collectionView!.delegate = self.toastDelegate
	}
}
```

### 3. Create a UICollectionviewCell that inherits from ToastCollectionViewCell

1. In your cell, instantiate the Toast view you created earlier
2. Override the `layoutIfNeeded()`  method
3. In  `layoutIfNeeded()`, pass the toast view to the `addToastView` method
4. You are done !


```swift
override func layoutIfNeeded() {
	super.layoutIfNeeded()
	let toastView = MyToast(frame: CGRect)
	addToastView(view: toastView, withMaximumHeightPosition: 75.0)
}
```

## 👱 Author

Oscar Gotting, gottingoscar@gmail.com

## 🚔 License

Hashtags is available under the MIT license. See the LICENSE file for more info.
