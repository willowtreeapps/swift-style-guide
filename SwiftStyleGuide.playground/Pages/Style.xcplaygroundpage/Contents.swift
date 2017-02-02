/*: 

# The Official WillowTree Swift Style Guide

## Table of Contents

* [Correctness](#correctness)
     * [Naming](#naming)
     * [Protocols](#protocols)
     * [Enumerations](#enumerations)
     * [Prose](#prose)
     * [Selectors](#selectors)
     * [Generics](#generics)
     * [Class Prefixes](#class-prefixes)
     * [Language](#language)
* [Code Organization](#code-organization)
     * [Protocol Conformance](#protocol-conformance)
     * [Unused Code](#unused-code)
     * [Minimal Imports](#minimal-imports)
* [Spacing](#spacing)
* [Comments](#comments)
* [Classes and Structures](#classes-and-structures)
     * [Use of Self](#use-of-self)
     * [Protocol Conformance](#protocol-conformance)
     * [Computed Properties](#computed-properties)
     * [Final](#final)
* [Function Declarations](#function-declarations)
* [Closure Expressions](#closure-expressions)
* [Types](#types)
     * [Constants](#constants)
     * [Static Methods and Variable Type Properties](#static-methods-and-variable-type-properties)
     * [Optionals](#optionals)
     * [Struct Initializers](#struct-initializers)
     * [Lazy Initialization](#lazy-initialization)
     * [OptionSetTypes](#optionsettypes)
     * [Type Inference](#type-inference)
     * [Syntactic Sugar](#syntactic-sugar)
* [Working with Storyboards](#storyboards)
* [Functions vs Methods](#functions-vs-methods)
* [Memory Management](#memory-management)
     * [Extending Lifetime](#extending-lifetime)
* [Access Control](#access-control)
* [Control Flow](#control-flow)
* [Golden Path](#golden-path)
     * [Failing Guards](#failing-guards)
* [Semicolons](#semicolons)
* [Parentheses](#parentheses)
* [Copyright Statement](#copyright-statement)
* [Credits](#credits)


## Correctness

Consider warnings to be errors. This rule informs many stylistic decisions such as not to use the `++` or `--` operators, C-style for loops, or strings as selectors.


## Naming

Use descriptive names with camel case for classes, methods, variables, etc. Type names (classes, structures, enumerations and protocols) should be capitalized, while method names and variables should start with a lower case letter.

**Preferred:**
*/
import UIKit

private let maximumWidgetCount = 100

class WidgetContainer {
    var widgetButton: UIButton!
    let widgetHeightPercentage = 0.85
}

/*:
**Not Preferred:**
 */
let MAX_WIDGET_COUNT = 100

class app_widgetContainer {
    var wBut: UIButton!
    let wHeightPct = 0.85
}

/*:
Abbreviations and acronyms should generally be avoided. Following the [API Design Guidelines](https://swift.org/documentation/api-design-guidelines/#follow-case-conventions), abbreviations and initialisms that appear in all uppercase should be uniformly uppercase or lowercase. Examples:

**Preferred**
*/

let urlString: URLString
let userID: UserID

//: **Not Preferred**
let uRLString: UrlString
let userId: UserId

//: For functions and init methods, prefer named parameters for all arguments unless the context is very clear. Include external parameter names if it makes function calls more readable.
import SpriteKit

func dateFromString(dateString: String) -> NSDate { return NSDate() }
func convertPointAt(column: Int, row: Int) -> CGPoint { return CGPoint(x: 0, y: 0) }
func timedAction(afterDelay delay: TimeInterval, perform action: SKAction) -> SKAction! { return SKAction() }

//: would be called like this:

dateFromString(dateString: "2014-03-14")
convertPointAt(column: 42, row: 13)
timedAction(afterDelay: 1.0, perform: SKAction())

//: For methods, follow the standard Apple convention of referring to the first parameter in the method name:

class Counter {
    func combineWith(otherCounter: Counter, options: Dictionary<Int, String>?) { }
    func incrementBy(amount: Int) { }
}


/*:
### Protocols

Following Apple's API Design Guidelines, protocols names that describe what something is should be a noun. Examples: `Collection`, `WidgetFactory`. Protocols names that describe an ability should end in -ing, -able, or -ible. Examples: `Equatable`, `Resizing`.

### Enumerations

Following Apple's API Design Guidelines for Swift 3, use lowerCamelCase for enumeration values.
 */

enum ShapeType {
    case rectangle
    case square
    case rightTriangle
    case equilateralTriangle
}

/*:
### Prose

When referring to functions in prose (tutorials, books, comments) include the required parameter names from the caller's perspective or `_` for unnamed parameters. Examples:

> Call `convertPointAt(column:row:)` from your own `init` implementation.
>
> If you call `dateFromString(_:)` make sure that you provide a string with the format "yyyy-MM-dd".
>
> If you call `timedAction(afterDelay:perform:)` from `viewDidLoad()` remember to provide an adjusted delay value and an action to perform.
>
> You shouldn't call the data source method `tableView(_:cellForRowAtIndexPath:)` directly.

This is the same as the `#selector` syntax. When in doubt, look at how Xcode lists the method in the jump bar – our style here matches that.

![Methods in Xcode jump bar](screens/xcode-jump-bar.png)


### Class Prefixes

Swift types are automatically namespaced by the module that contains them and you should not add a class prefix such as RW. If two names from different modules collide you can disambiguate by prefixing the type name with the module name. However, only specify the module name when there is possibility for confusion which should be rare.

```
import SomeModule

let myClass = MyModule.UsefulClass()
```

### Selectors

Selectors are Obj-C methods that act as handlers for many Cocoa and Cocoa Touch APIs. Prior to Swift 2.2, they were specified using type unsafe strings. This now causes a compiler warning. The "Fix it" button replaces these strings with the **fully qualified** type safe selector. Often, however, you can use context to shorten the expression. This is the preferred style.

**Preferred:**
 */
class ViewController: UIViewController {
    let sel = #selector(viewDidLoad)
}

//: **Not Preferred:**
class ViewControllerNotPreferred: UIViewController {
    let sel = #selector(ViewController.viewDidLoad)
}

/*:
### Generics

Generic type parameters should be descriptive, upper camel case names. When a type name doesn't have a meaningful relationship or role, use a traditional single uppercase letter such as `T`, `U`, or `V`.

**Preferred:**
 */

struct Stack<Element> {}
func writeTo<Target: OutputStream>( target: inout Target) {}
func max<T: Comparable>(x: T, _ y: T) -> T { return x }

//: **Not Preferred:**

struct GenericStack<T> {}
func writeNotPreferred<target: OutputStream>( t: inout target) {}
func maxNotPreferred<Thing: Comparable>(x: Thing, _ y: Thing) -> Thing { return x }

/*:
### Language

Use US English spelling to match Apple's API.

**Preferred:**
 */
let color = "red"

//: **Not Preferred:**
let colour = "red"

/*:
## Code Organization

Use extensions to organize your code into logical blocks of functionality. Each extension should be set off with a `// MARK: -` comment to keep things well-organized.

### Protocol Conformance

In particular, when adding protocol conformance to a model, prefer adding a separate extension for the protocol methods. This keeps the related methods grouped together with the protocol and can simplify instructions to add a protocol to a class with its associated methods.

**Preferred:**
 */
class MyViewController: UIViewController {
    // class stuff here
}

// MARK: - UITableViewDataSource
extension MyViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return 0 }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell(style: .default, reuseIdentifier: nil)
    }
}

// MARK: - UIScrollViewDelegate
extension MyViewController: UIScrollViewDelegate {
    // scroll view delegate methods
}

//: **Not Preferred:**
class MyViewControllerNotPreferred: UIViewController, UITableViewDataSource, UIScrollViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return 0 }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell(style: .default, reuseIdentifier: nil)
    }
}

/*:
Since the compiler does not allow you to re-declare protocol conformance in a derived class, it is not always required to replicate the extension groups of the base class. This is especially true if the derived class is a terminal class and a small number of methods are being overridden. When to preserve the extension groups is left to the discretion of the author.

For UIKit view controllers, consider grouping lifecycle, custom accessors, and IBAction in separate class extensions.

### Unused Code

Unused (dead) code, including Xcode template code and placeholder comments should be removed.

Methods whose implementation simply calls the super class should also be removed. This includes any empty/unused UIApplicationDelegate methods.

**Not Preferred:**
 */
class EmptyViewController: UIViewController {
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

class EmptyTableViewController: UITableViewController {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Database.contacts.count
    }
}

//: **Preferred:**
func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return Database.contacts.count
}

/*:
### Minimal Imports

Keep imports minimal. For example, don't import `UIKit` when importing `Foundation` will suffice.

## Spacing

* Use the Xcode defaults for tab spacing (4 spaces and spaces instead of tabs).

![Xcode indent settings](screens/indentation.png)

* Method braces and other braces (`if`/`else`/`switch`/`while` etc.) always open on the same line as the statement but close on a new line.
* Tip: You can re-indent by selecting some code (or ⌘A to select all) and then Control-I (or Editor\Structure\Re-Indent in the menu).

**Preferred:**
 */
if let user = User.loggedInUser() {
    if user.isHappy {
        // Be happy
    } else {
        // Turn that frown upside down!
    }
}

//: **Not Preferred:**
if let user = User.loggedInUser()
{
  if user.isHappy
  {
    // Do something
  }
  else {
    // Do something else
  }
}

/*:

* There should be exactly one blank line between methods to aid in visual clarity and organization. Whitespace within methods should separate functionality, but having too many sections in a method often means you should refactor into several methods.

* Colons always have no space on the left and one space on the right. Exceptions are the ternary operator `? :` and empty dictionary `[:]`.

**Preferred:**
 */
class TestDatabase: Database {
    var data: [String: CGFloat] = ["A": 1.2, "B": 3.2]
}

//: **Not Preferred:**
class TestDatabaseNotPreferred : Database {
    var data :[String:CGFloat] = ["A" : 1.2, "B":3.2]
}

/*:
## Comments

When they are needed, use comments to explain **why** a particular piece of code does something. Comments must be kept up-to-date or deleted.

Avoid block comments inline with code, as the code should be as self-documenting as possible. *Exception: This does not apply to those comments used to generate documentation.*


## Classes and Structures

### Which one to use?

Remember, structs have [value semantics](https://developer.apple.com/library/mac/documentation/Swift/Conceptual/Swift_Programming_Language/ClassesAndStructures.html#//apple_ref/doc/uid/TP40014097-CH13-XID_144). Use structs for things that do not have an identity. An array that contains [a, b, c] is really the same as another array that contains [a, b, c] and they are completely interchangeable. It doesn't matter whether you use the first array or the second, because they represent the exact same thing. That's why arrays are structs.

Classes have [reference semantics](https://developer.apple.com/library/mac/documentation/Swift/Conceptual/Swift_Programming_Language/ClassesAndStructures.html#//apple_ref/doc/uid/TP40014097-CH13-XID_145). Use classes for things that do have an identity or a specific life cycle. You would model a person as a class because two person objects are two different things. Just because two people have the same name and birthdate, doesn't mean they are the same person. But the person's birthdate would be a struct because a date of 3 March 1950 is the same as any other date object for 3 March 1950. The date itself doesn't have an identity.

Sometimes, things should be structs but need to conform to `AnyObject` or are historically modeled as classes already (`NSDate`, `NSSet`). Try to follow these guidelines as closely as possible.

### Example definition

Here's an example of a well-styled class definition:
*/

class Circle: Shape {

    var diameter: Double {
        get {
            return radius * 2
        }
        set {
            radius = newValue / 2
        }
    }

    convenience init(x: Int, y: Int, diameter: Double) {
        self.init(x: x, y: y, radius: diameter / 2)
    }

    func describe() -> String {
        return "I am a circle at \(centerString()) with an area of \(computeArea())"
    }

    override func computeArea() -> Double {
        return M_PI * radius * radius
    }

    private func centerString() -> String {
        return "(\(x),\(y))"
    }
}

/*:
The example above demonstrates the following style guidelines:

* Specify types for properties, variables, constants, argument declarations and other statements with a space after the colon but not before, e.g. `x: Int`, and `Circle: Shape`.
* Define multiple variables and structures on a single line if they share a common purpose / context.
* Indent getter and setter definitions and property observers.
* Don't add modifiers such as `internal` when they're already the default. Similarly, don't repeat the access modifier when overriding a method.


### Use of Self

For conciseness, avoid using `self` since Swift does not require it to access an object's properties or invoke its methods.

Use `self` when required to differentiate between property names and arguments in initializers, and when referencing properties in closure expressions (as required by the compiler):
 */

class BoardLocation {
    let row: Int, column: Int

    init(row: Int, column: Int) {
        self.row = row
        self.column = column

        let closure = {
            print(self.row)
        }

        closure()
    }
}

/*:
### Computed Properties

For conciseness, if a computed property is read-only, omit the get clause. The get clause is required only when a set clause is provided.

**Preferred:**
 */
struct PreferredCircle {
    var radius = 2.0

    var diameter: Double {
        return radius * 2
    }
}

//: **Not Preferred:**
struct NotPreferredCircle {

    var radius = 2.0

    var diameter: Double {
        get {
            return radius * 2
        }
    }
}

/*:
### Final

Mark classes `final` when inheritance is not intended. Example:
*/

// We don't allow subclassing of an equilateral triangle
final class EquilateralTriangle : Triangle {
    var sideLength: Int = 0

    init(sideLength: Int) {
        super.init()
        self.sideLength = sideLength
    }
}

/*:
## Function Declarations

Keep short function declarations on one line including the opening brace:
 */

func reticulateSplines(spline: [Double]) -> Bool {
    // reticulate code goes here
    return true
}

/*:
For functions with long signatures, add line breaks at appropriate points and add an extra indent on subsequent lines:
*/

func reticulateSplines(spline: [Double], adjustmentFactor: Double,
                       translateConstant: Int, comment: String) -> Bool {
    // reticulate code goes here
    return true
}

/*:
## Closure Expressions

Use trailing closure syntax only if there's a single closure expression parameter at the end of the argument list. Give the closure parameters descriptive names.

**Preferred:**
 */
let myView = UIView()
UIView.animate(withDuration: 1.0) {
    myView.alpha = 0
}

UIView.animate(withDuration: 1.0,
               animations: {
                myView.alpha = 0
    },
               completion: { finished in
                myView.removeFromSuperview()
    }
)

//: **Not Preferred:**

UIView.animate(withDuration: 1.0, animations: {
    myView.alpha = 0
})

UIView.animate(withDuration: 1.0,
animations: {
myView.alpha = 0
}) { f in
    myView.removeFromSuperview()
}

//: For single-expression closures where the context is clear, use implicit returns:
let attendeeList = ["Tim Cook", "Phil Schiller"]
attendeeList.sorted { a, b in
    a > b
}


//: Chained methods using trailing closures should be clear and easy to read in context. Decisions on spacing, line breaks, and when to use named versus anonymous arguments is left to the discretion of the author. Examples:
let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9]
let value = numbers.map { $0 * 2 }.filter { $0 % 3 == 0 }.index(of: 90)

let newValues = numbers
    .map {$0 * 2}
    .filter {$0 > 50}
    .map {$0 + 10}

/*:
## Types

Always use Swift's native types when available. Swift offers bridging to Objective-C so you can still use the full set of methods as needed.

**Preferred:**
 */
let width = 120.0                                    // Double
let widthString = (width as NSNumber).stringValue    // String

//: **Not Preferred:**

let secondWidth: NSNumber = 120.0                          // NSNumber
let secondWidthString: NSString = secondWidth.stringValue as NSString        // NSString

/*:
In Sprite Kit code, use `CGFloat` if it makes the code more succinct by avoiding too many conversions.

### Constants

Constants are defined using the `let` keyword, and variables with the `var` keyword. Always use `let` instead of `var` if the value of the variable will not change.

**Tip:** A good technique is to define everything using `let` and only change it to `var` if the compiler complains!

You can define constants on a type rather than an instance of that type using type properties. To declare a type property as a constant simply use `static let`. Type properties declared in this way are generally preferred over global constants because they are easier to distinguish from instance properties. Example:

**Preferred:**
 */

enum AstronomicalUnits {
    static let c = 299792458
    static let parsec = 3.08567758128 * pow(Double(10), Double(16))
    static let lightYear = 9.4607304725808 * pow(Double(10), Double(15))
}

let kesselRun = 12 * AstronomicalUnits.parsec

/*: 
 **Note:** The advantage of using a case-less enumeration is that it can't accidentally be instantiated and works as a pure namespace.

 **Not Preferred:**
 */

let c = 299792458 // pollutes global namespace
let parsec = 3.08567758128 * pow(Double(10), Double(16))
let lightYear = 9.4607304725808 * pow(Double(10), Double(15))

let globalKesselRun = 12 * parsec // is parsec instance data or a global constant?

/*:
### Static Methods and Variable Type Properties

Static methods and type properties work similarly to global functions and global variables and should be used sparingly. They are useful when functionality is scoped to a particular type or when Objective-C interoperability is required.

### Optionals

Declare variables and function return types as optional with `?` where a nil value is acceptable. Use the default nil initializer when declaring optional types.

**Preferred**
 */
struct Person {
    let name: String
    let nickname: String?
}

//: **Not Preferred**
struct PersonTwo {
    let name: String
    let nickname: String? = nil
}

/*:
Use implicitly unwrapped types declared with `!` only for instance variables that you know will be initialized later before use, such as subviews that will be set up in `viewDidLoad`.

When accessing an optional value, use optional chaining if the value is only accessed once or if there are many optionals in the chain:
 */
var textContainer: TextContainer?
textContainer?.textLabel?.setNeedsDisplay()

//: Use optional binding when it's more convenient to unwrap once and perform multiple operations:

if let textContainer = textContainer {
    // do many things with textContainer
}

/*:
When naming optional variables and properties, avoid naming them like `optionalString` or `maybeView` since their optional-ness is already in the type declaration.

For optional binding, shadow the original name when appropriate rather than using names like `unwrappedView` or `actualLabel`.

**Preferred:**
 */
var subview: UIView?
var volume: Double?

// later on...
if let subview = subview, let volume = volume {
    // do something with unwrapped subview and volume
}

//: **Not Preferred:**
var unpreferredOptionalSubview: UIView?
var unpreferredVolume: Double?

if let unwrappedSubview = unpreferredOptionalSubview {
    if let realVolume = unpreferredVolume {
        // do something with unwrappedSubview and realVolume
    }
}

/*:
### Struct Initializers

Use the native Swift struct initializers rather than the legacy struct constructors if they are still available.
**Preferred:**
 */
let bounds = CGRect(x: 40, y: 20, width: 120, height: 80)
let centerPoint = CGPoint(x: 96, y: 42)

//: **Not Preferred:**

// These were deprecated in Swift 3
// let unpreferredBounds = CGRectMake((40, 20, 120, 80)
// let unpreferredCenterPoint = CGPointMake(96, 42)

/*:
Prefer the struct-scope constants `CGRect.infinite`, `CGRect.null`, etc. over global constants `CGRectInfinite`, `CGRectNull`, etc. For existing variables, you can use the shorter `.zero`.


### Lazy Initialization

Consider using lazy initialization for finer grain control over object lifetime. This is especially true for `UIViewController` that loads views lazily. You can either use a closure that is immediately called `{ }()` or call a private factory method. Example:
 */
import CoreLocation
class MyLocationManager: NSObject, CLLocationManagerDelegate {
    lazy var locationManager: CLLocationManager = self.makeLocationManager()

    private func makeLocationManager() -> CLLocationManager {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        manager.requestAlwaysAuthorization()
        return manager
    }
}

/*:
**Notes:**
- `[unowned self]` is not required here. A retain cycle is not created.
- Location manager has a side-effect for popping up UI to ask the user for permission so fine grain control makes sense here.

### OptionSetTypes

When using OptionSetTypes, signify the "no" option using an empty array literal rather than the rawValue initializer. For example, given:
*/
struct PackagingOptions : OptionSet {
    let rawValue: Int
    init(rawValue: Int) { self.rawValue = rawValue }
    static let box = PackagingOptions(rawValue: 1)
    static let carton = PackagingOptions(rawValue: 2)
}

let options: PackagingOptions = [.box]
func placeOrder(orderId: String, options: PackagingOptions) { }

//: **Preferred:**

placeOrder(orderId: "1234", options: [])

//: **Not Preferred:**

placeOrder(orderId: "1234", options: PackagingOptions(rawValue: 0))

/*:
### Type Inference

Prefer compact code and let the compiler infer the type for constants or variables of single instances. Type inference is also appropriate for small (non-empty) arrays and dictionaries. When required, specify the specific type such as `CGFloat` or `Int16`.

**Preferred:**
 */
import CoreGraphics
func computeViewBounds() -> CGRect {
    return CGRect.zero
}

let message = "Click the button"
let currentBounds = computeViewBounds()
var names = ["Mic", "Sam", "Christine"]
let maximumWidth: CGFloat = 106.5

//: **Not Preferred:**
let unpreferredMessage: String = "Click the button"
let unpreferredCurrentBounds: CGRect = computeViewBounds()
var unpreferredNames: [String] = ["Mic", "Sam", "Christine"]
let unpreferredMaximumWidth = CGFloat(106.5)

/*:
#### Type Annotation for Empty Arrays and Dictionaries

For empty arrays and dictionaries, use type annotation. (For an array or dictionary assigned to a large, multi-line literal, use type annotation.)

**Preferred:**
 */
var namesList: [String] = []
var lookup: [String: Int] = [:]

//: **Not Preferred:**
var unpreferredNamesList = [String]()
var unpreferredLookup = [String: Int]()

/*:
 **NOTE**: Following this guideline means picking descriptive names is even more important than before.

 ### Syntactic Sugar

Prefer the shortcut versions of type declarations over the full generics syntax.

**Preferred:**
 */
var deviceModels: [String]
var employees: [Int: String]
var faxNumber: Int?

//: **Not Preferred:**
var unpreferredDeviceModels: Array<String>
var unpreferredEmployees: Dictionary<Int, String>
var unpreferredFaxNumber: Optional<Int>

/*:
## Functions vs Methods

Free functions, which aren't attached to a class or type, should be used sparingly. When possible, prefer to use a method instead of a free function. This aids in readability and discoverability.

Free functions are most appropriate when they aren't associated with any particular type or instance.

**Preferred**
 */
let items = [1, 3, 5, 6, 3, 1]
let rocket = Rocket()

let sorted = items.mergeSort()  // easily discoverable
rocket.launch()  // clearly acts on the model

//: **Not Preferred**
let unpreferredSorted = mergeSort(array: items)  // hard to discover
launch(rocket: rocket)

//: **Free Function Exceptions**
let tuples = zip(a: 1, b: 2)  // feels natural as a free function (symmetry)
let maxValue = max(a: 2, b: 3, c: 5)  // another free function that feels natural

/*:
## Memory Management

Code (even non-production, tutorial demo code) should not create reference cycles. Analyze your object graph and prevent strong cycles with `weak` and `unowned` references. Alternatively, use value types (`struct`, `enum`) to prevent cycles altogether.

### Extending object lifetime

Extend object lifetime using the `[weak self]` and `guard let strongSelf = self else { return }` idiom. `[weak self]` is preferred to `[unowned self]` where it is not immediately obvious that `self` outlives the closure. Explicitly extending lifetime is preferred to optional unwrapping. The exception is if self is only referenced once in a single line, then optional unwrapping is preferred.

**Preferred**
 */
class SimpleController {
    let resource = Resource()

    func updateModel(response: Response) -> Model {
        return Model()
    }
    
    func updateUI(model: Model) {}

    func update() {
        resource.request().onComplete = { [weak self] response in
            guard let strongSelf = self else { return }
            let model = strongSelf.updateModel(response: response)
            strongSelf.updateUI(model: model)
        }
    }

    func oneLineUpdate() {
        resource.request().onComplete = { [weak self] response in
            self?.handleResponse(response: response)
        }
    }

    func handleResponse(response: Response) {

    }
}


//: **Not Preferred**

extension SimpleController {
    func notPreferredUpdate() {
        // might crash if self is released before response returns
        resource.request().onComplete = { [unowned self] response in
            let model = self.updateModel(response: response)
            self.updateUI(model: model)
        }

        // deallocate could happen between updating the model and updating UI
        resource.request().onComplete = { [weak self] response in
            if let model = self?.updateModel(response: response) {
                self?.updateUI(model: model)
            }
        }

    }
}

/*:
## Access Control

Use `private` as the leading property specifier. The only things that should come before access control are the `static` specifier or attributes such as `@IBAction` and `@IBOutlet`.

**Preferred:**
 */
class TimeMachine {
    private lazy var fluxCapacitor = FluxCapacitor()
}

//: **Not Preferred:**
class UnpreferredTimeMachine {
    lazy private var fluxCapacitor = FluxCapacitor()
}

/*:
## Control Flow

Prefer the `for-in` style of `for` loop over the `while-condition-increment` style.

**Preferred:**
 */
for _ in 0..<3 {
    print("Hello three times")
}

for (index, person) in attendeeList.enumerated() {
    print("\(person) is at position #\(index)")
}

for index in stride(from: 0, to: items.count, by: 2) {
    print(index)
}

for index in (0...3).reversed() {
    print(index)
}

//: **Not Preferred:**
var i = 0
while i < 3 {
    print("Hello three times")
    i += 1
}


i = 0
while i < attendeeList.count {
    let person = attendeeList[i]
    print("\(person) is at position #\(i)")
    i += 1
}

/*:
## Golden Path

When coding with conditionals, the left hand margin of the code should be the "golden" or "happy" path. That is, don't nest `if` statements. Multiple return statements are OK. The `guard` statement is built for this.
*/
//: **Preferred:**
func computeFFT(context: Context?, inputData: InputData?) throws -> Frequencies {

    guard let _ = context else { throw FFTError.noContext }
    guard let _ = inputData else { throw FFTError.noInputData }

    let frequencies = Frequencies()

    // use context and input to compute the frequencies

    return frequencies
}

//: **Not Preferred:**
func notPreferredComputeFFT(context: Context?, inputData: InputData?) throws -> Frequencies {

    let frequencies = Frequencies()

    if let _ = context {
        if let _ = inputData {
            // use context and input to compute the frequencies

            return frequencies
        }
        else {
            throw FFTError.noInputData
        }
    }
    else {
        throw FFTError.noContext
    }
}

//: When multiple optionals are unwrapped either with `guard` or `if let`, minimize nesting by using the compound version when possible. Example:
//: **Preferred:**
var number1: Int?
var number2: Int?
var number3: Int?

func numberTest() {
    guard let number1 = number1, let number2 = number2, let number3 = number3 else { fatalError("impossible") }

    print("\(number1 + number2 + number3)")
}
// do something with numbers

//: **Not Preferred:**
func numberTestNotPreferred() {
    if let number1 = number1 {
        if let number2 = number2 {
            if let number3 = number3 {
                // do something with numbers

                print("\(number1 + number2 + number3)")
            }
            else {
                fatalError("impossible")
            }
        }
        else {
            fatalError("impossible")
        }
    }
    else {
        fatalError("impossible")
    }
}

/*:
### Failing Guards

Guard statements are required to exit in some way. Generally, this should be simple one line statement such as `return`, `throw`, `break`, `continue`, and `fatalError()`. Large code blocks should be avoided. If cleanup code is required for multiple exit points, consider using a `defer` block to avoid cleanup code duplication.

## Semicolons

Swift does not require a semicolon after each statement in your code. They are only required if you wish to combine multiple statements on a single line.

Do not write multiple statements on a single line separated with semicolons.

The only exception to this rule is the `for-conditional-increment` construct, which requires semicolons. However, alternative `for-in` constructs should be used where possible.
**Preferred:**
 */
let swift = "not a scripting language"

//: **Not Preferred:**
let unpreferredSwift = "not a scripting language";

/*:
## Parentheses

Parentheses around conditionals are not required and should be omitted.
**Preferred:**
 */
let name = "Hello"

if name == "Hello" {
    print("World")
}

//: **Not Preferred:**
if (name == "Hello") {
    print("World")
}

/*:
## Storyboards

When instantiating view controllers from storyboards, it is impossible to use
non-optional property types since the view controller's lifecycle is out of the app's direct
control.

To mitigate problems with uninitialized optionals, it is useful to put the
normal initialization work in a helper method.

- For instantiation, consider a factory method, conventionally named `make`.
- For preparation during segue, consider a method named `prepare`.
- Both methods should require external names for all parameters, to mimic
the feel of initializers.

**Example `make`**
*/
class ProfileViewController: UIViewController {
    var user: User!
    static func make(user: User) -> ProfileViewController {
        let storyboard = UIStoryboard(name: "ProfileViewController", bundle: nil)
        let controller = storyboard.instantiateInitialViewController() as! ProfileViewController
        controller.user = user
        return controller
    }
}

//*:**Example `prepare`**
class PrepareProfileViewController: UIViewController {
    var user: User!
    func prepare(user: User) {
        self.user = user
    }
}

/*:
**Combined Example**

Naturally, if a controller could be instantiated directly, or navigated to via
a segue, the approaches should be combined:
 */
class CombinedProfileViewController: UIViewController {
    var user: User!
    static func make(user: User) -> CombinedProfileViewController {
        let storyboard = UIStoryboard(name: "ProfileViewController", bundle: nil)
        let controller = storyboard.instantiateInitialViewController() as! CombinedProfileViewController
        controller.prepare(user: user)
        return controller
    }

    func prepare(user: User) {
        self.user = user
    }
}

/*:
## Copyright Statement

When writing client software, use their appropriate copyright notice, or the default Xcode
copyright.

For open source WillowTree projects, the following copyright statement should be included at
the top of every source file and as part of a LICENSE file at the root of the system directory:
*/

 /*
 * Copyright (c) 2016 WillowTree, Inc.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

/*:
 ## Credits

 This style guide originated from the raywenderlich.com style guide at https://github.com/raywenderlich/swift-style-guide

 We also draw inspiration from Apple’s reference material on Swift:

 * [The Swift API Design Guidelines](https://swift.org/documentation/api-design-guidelines/)
 * [The Swift Programming Language](https://developer.apple.com/library/prerelease/ios/documentation/swift/conceptual/swift_programming_language/index.html)
 * [Using Swift with Cocoa and Objective-C](https://developer.apple.com/library/prerelease/ios/documentation/Swift/Conceptual/BuildingCocoaApps/index.html)
 * [Swift Standard Library Reference](https://developer.apple.com/library/prerelease/ios/documentation/General/Reference/SwiftStandardLibraryReference/index.html)
 */
