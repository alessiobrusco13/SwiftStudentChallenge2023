import SwiftUI

struct PaletteItem: Identifiable, Codable, Equatable {
    enum Role: Codable {
        case accent, text, background
    }
    
    var id = UUID()
    var color = Color.black
    var role: Role?
    var name: String?
    var feeling: Feeling?
    
    static func ==(lhs: PaletteItem, rhs: PaletteItem) -> Bool {
        lhs.id == rhs.id
    }
}

extension PaletteItem {
    init(colorName: ColorName) {
        self.init(color: Color(rgb: colorName.rgbValues), name: colorName.name)
    }
}
