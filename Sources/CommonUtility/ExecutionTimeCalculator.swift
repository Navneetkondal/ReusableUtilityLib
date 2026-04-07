


import Foundation

public struct ExecutionTimeCalculator {
    
    private var id: UUID
    private let name: String
    private var startTime: CFAbsoluteTime
    
    public init(_ name: String = #function) {
        self.id = UUID()
        self.name = name
        self.startTime = CFAbsoluteTimeGetCurrent()
    }
    
    @discardableResult
    mutating func start() -> Double{
        self.startTime = CFAbsoluteTimeGetCurrent()
        return startTime
    }
    
    @discardableResult
    public func stop(with msg: String? = nil) -> Double {
        let endTime = CFAbsoluteTimeGetCurrent() - startTime
        print(String(format: "\(msg ?? name): %.5f sec.", endTime))
        return endTime
    }
}
