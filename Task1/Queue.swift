
import Foundation
internal struct Queue<T> {
    fileprivate var array = [T]()

    internal var count: Int {
        return array.count
    }

    internal var isEmpty: Bool {
        return array.isEmpty
    }

    internal mutating func enqueue(_ element: T) {
        array.append(element)
    }

    internal mutating func dequeue() -> T? {
        return isEmpty ? nil : array.removeFirst()
    }

    internal var front: T? {
        return array.first
    }
}
