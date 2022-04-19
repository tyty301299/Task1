

import Foundation
internal struct Stack<T> {
    fileprivate var array = [T]()

    internal var isEmpty: Bool {
        return array.isEmpty
    }

    internal var count: Int {
        return array.count
    }

    internal mutating func push(_ element: T) {
        array.append(element)
    }

    internal mutating func pop() -> T? {
        return array.popLast()
    }

    internal var top: T? {
        return array.last
    }
}
