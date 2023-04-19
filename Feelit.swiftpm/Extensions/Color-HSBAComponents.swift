import SwiftUI

extension Color {
    var hsbaComponents: (hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat)? {
        var h: CGFloat = 0
        var s: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        guard UIColor(self).getHue(&h, saturation: &s, brightness: &b, alpha: &a) else {
            return nil
        }
        
        return (h, s, b, a)
    }
}
