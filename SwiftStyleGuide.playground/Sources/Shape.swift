import Foundation

open class Shape {

    open var x: Int
    open var y: Int
    open var radius: Double

    public init(x: Int, y: Int, radius: Double) {
        self.x = x
        self.y = y
        self.radius = radius
    }

    open func computeArea() -> Double {
        return 0
    }
}

open class Triangle {

    public init() {

    }
}
