import SwiftUI

struct PaletteItem: Identifiable, Codable, Equatable {
    enum Role: Codable, CaseIterable {
        case accent, text, background
        
        var sfSymbol: String {
            switch self {
            case .accent:
                return "square.dashed.inset.fill"
            case .background:
                return "doc.richtext.fill"
            case .text:
                return "character.cursor.ibeam"
            }
        }
    }
    
    var id = UUID()
    var color = Color.black
    var name = "Untitled"
    var role: Role?
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
