import Foundation

public class Response {

}

public typealias RequestCompletion = (Response) -> Void

public class Request {
    public var onComplete: RequestCompletion?
}

public class Resource {

    public init() {

    }

    public func request() -> Request {
        return Request()
    }
}

public struct Model {
    public init() {
        
    }
}
