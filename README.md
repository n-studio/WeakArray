## Swift WeakArray

WeakArray offers a collection type that behaves like a Swift Array, but will not retain any of its objects.

	
## Installation

WeakArray is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "WeakArray"
```

## Usage

First make sure to import WeakArray:

	import WeakArray
	
When creating a weak array, specify the collection type as you would with an Array:
	
	typealias myType = AnyObject
	var a: WeakArray<MyType> = []
	
You can also use array literals to create a WeakArray, but if you specify any values you'll need to unwrap your optionals with ```!```:

	var view: UIView? = UIView()
	var a: WeakArray<UIView> = [view!]
	
Otherwise a WeakArray works much like an Array:

	var a: WeakArray<AnyObject> = []
	
	var view: UIView? = UIView()
	
	// Append
	a.append(view)
	
	// Replace with index
	a[0] = view
	
	// Replace with range
	a[0...1] = [view, view]
	
	// Remove Last
	a.removeLast()
	
	// Remove at index
	var view: UIView? = a.removeAtIndex(0)
	
	// Insert at index
	a.insert(view, atIndex: 0)
	
	// isEmpty and count
	if (!a.isEmpty) {
		println("Count: \(a.count)")
	}
	
	// First and Last
	var first: AnyObject? = a.first
	var last: AnyObject? = a.last
	
	// Append WeakArray
	var b: WeakArray<AnyObject>() = []
	a += b
	
	// Or append a standard library Array
	var c: [AnyObject] = []
	a += c

Most of the methods you'll find in the Slice struct are implemented on WeakArray, so if there's an Array method you need, it is probably implemented. If you find a need for any of the few that are not implemented, let me know.

You can also enumerate over a WeakArray like you would an Array, but keep in mind it will skip over nil values while count will include them, so **count may not
match the number of enumerations you get**.

	func testIterationIsNotInterruptedByNilObject() {
        var a = WeakArray<UIView>()
        var obj1: UIView? = UIView()
        var obj2: UIView? = UIView()
        var obj3: UIView? = UIView()
        a.append(obj1)
        a.append(obj2)
        a.append(obj3)
        obj2 = nil
        var i = 0     
        for value in a {
            i++
        }
        XCTAssert(a.count == 3, "")
        XCTAssert(i == 2, "")
    }
    
## Version History

**v0.4**

* Updated to Swift 3
* Made available via cocoapods

**v0.3**

* Update for Swift 1.0. Thanks to [Mazyod](https://github.com/Mazyod) in [Pull Request #1](https://github.com/dmauro/WeakArray/pull/1).
* Implemented more Slice methods.
* Added equality operator overload.

**v0.2**

* Update to match beta 5 array changes
* Use ArrayLiteralConvertible

**v0.1**

* Released!
	
## Author

David Mauro, email@dmauro.com

## License

WeakArray is available under the Apache license. See the LICENSE file for more info.
