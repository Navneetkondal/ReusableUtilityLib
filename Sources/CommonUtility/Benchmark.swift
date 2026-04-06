


import Foundation

public struct Benchmark {
    
    private let name: String
    private let startTime: CFAbsoluteTime
    
    public init(_ name: String = #function) {
        self.name = name
        self.startTime = CFAbsoluteTimeGetCurrent()
    }
    
    @discardableResult
    public func stop(with msg: String? = nil) -> Double {
        let endTime = CFAbsoluteTimeGetCurrent() - startTime
        print(String(format: "\(msg ?? name): %.5f sec.", endTime))
        return endTime
    }
}
