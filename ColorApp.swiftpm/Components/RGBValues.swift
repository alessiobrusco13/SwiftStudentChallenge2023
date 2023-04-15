import Foundation

infix operator |-|
infix operator +<

struct RGBValues: Equatable {
    var red: Int
    var green: Int
    var blue: Int
    
    var doubleValues: (red: Double, green: Double, blue: Double) {
        (Double(red) / 255.0, Double(green) / 255.0, Double(blue) / 255.0)
    }
    
    var tuple: (red: Int, green: Int, blue: Int) {
        (red, green, blue)
    }
    
    static func |-|(_ lhs: RGBValues, _ rhs: RGBValues) -> RGBValues {
        RGBValues(
            red: lhs.red |-| rhs.red,
            green: lhs.green |-| rhs.green,
            blue: lhs.blue |-| rhs.blue
        )
    }
    
    static func +<(_ lhs: RGBValues, _ rhs: RGBValues) -> Bool {
        (lhs.red + lhs.green + lhs.blue) < (rhs.red + rhs.green + rhs.blue)
    }
}

extension RGBValues {
    init(_ red: Int, _ gren: Int, _ blue: Int) {
        self.red = red
        self.green = gren
        self.blue = blue
    }
    
    init(_ red: Double, _ green: Double, _ blue: Double) {
        self.red = Int((red * 255.0).rounded())
        self.green = Int((green * 255.0).rounded())
        self.blue = Int((blue * 255.0).rounded())
    }
}
