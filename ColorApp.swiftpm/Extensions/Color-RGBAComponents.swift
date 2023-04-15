import SwiftUI

extension Color {
    var rgbaComponents: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)? {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        guard UIColor(self).getRed(&r, green: &g, blue: &b, alpha: &a) else {
            return nil
        }
        
        return (r, g, b, a)
    }
    
    var rgbValues: RGBValues {
        guard let (red, green, blue, _) = rgbaComponents else { return RGBValues(0, 0, 0) }
        return RGBValues(red, green, blue)
    }
}
