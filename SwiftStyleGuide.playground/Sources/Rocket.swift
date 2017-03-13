import Foundation

public class Rocket {

    public init() {

    }
    
    public func launch() {
        print("Launching")
    }
}

public func launch(rocket: Rocket) {
    print("Launch failure")
}
