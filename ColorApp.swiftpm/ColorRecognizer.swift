import Foundation

struct ColorRecognizer {
    enum Output: CaseIterable {
        case red, yellow, green, blue, pink, violet, purple, orange, /*brown,*/ black, white, grey
        
        var baseRGB: RGBValues? {
            switch self {
            case .red:
                return RGBValues(255, 0, 0)
            case .yellow:
                return RGBValues(255, 255, 0)
            case .green:
                return RGBValues(0, 255, 0)
            case .blue:
                return RGBValues(0, 0, 255)
            case .pink:
                return RGBValues(255, 192, 203)
            case .violet:
                return RGBValues(143, 0, 255)
            case .purple:
                return RGBValues(160, 32, 240)
            case .orange:
                return RGBValues(255, 165, 0)
//            case .brown:
//                return RGBValues(150, 75, 0)
            default:
                return nil
            }
        }
    }
    
    
    func color(for item: PaletteItem) -> Output? {
        let itemRGB = item.color.rgbValues
        
        if isBlack(itemRGB) { return .black }
        if isWhite(itemRGB) { return .white }
        if isGrey(itemRGB) { return .grey }
        
        if itemRGB.green == 0 && itemRGB.blue == 0 {
            return .red
        } else if itemRGB.red == 0 && itemRGB.blue == 0 {
            return .green
        } else if itemRGB.red == 0 && itemRGB.green == 0 {
            return .blue
        }
        
        let deltas = deltas(for: itemRGB)
        guard let minDelta = deltas.values.min(by: +<) else { return nil }
        
        let outputPair = deltas.first { $0.value == minDelta }
        return outputPair?.key
    }
    
    private func deltas(for itemRGB: RGBValues) -> [Output: RGBValues] {
        var deltas = [Output: RGBValues]()
        
        for color in Output.allCases {
            guard let baseRGB = color.baseRGB else { continue }
            deltas[color] = baseRGB |-| itemRGB
        }
        
        return deltas
    }
    
    func isGrey(_ rgb: RGBValues) -> Bool {
        // The grey color is obtained when (r=g=b)±5max [x], with 25<x<230
        guard isContained(in: 26...229, rgb: rgb) else { return false }
        
        let (red, green, blue) = rgb.tuple
        return (red |-| green) <= 5 && (red |-| blue) <= 5 && (green |-| blue) <= 5
    }
    
    func isBlack(_ rgb: RGBValues) -> Bool {
        // Black if r, g and b are between 0-25
        isContained(in: 0...25, rgb: rgb)
    }
    
    func isWhite(_ rgb: RGBValues) -> Bool {
        // White if r, g and b are between 230-255
        isContained(in: 230...255, rgb: rgb)
    }
    
    private func isContained(in range: ClosedRange<Int>, rgb: RGBValues) -> Bool {
        range.contains(rgb.red) && range.contains(rgb.green) && range.contains(rgb.blue)
    }
}
