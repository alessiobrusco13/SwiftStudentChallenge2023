import Foundation

extension SignedNumeric where Self: Comparable {
    static func |-|(_ lhs: Self, _ rhs: Self) -> Self {
        abs(lhs - rhs)
    }
}
