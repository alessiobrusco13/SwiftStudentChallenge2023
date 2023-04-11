import SwiftUI

struct Palette: Identifiable, Codable, Hashable, Transferable {
    var id = UUID()
    var name = "Untitled"
    var items = [PaletteItem]()
    
    // want to represent it as a folder of colours.
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(for: Palette.self, contentType: .data)
    }
    
    func hash(into hasher: inout Hasher) {
        id.hash(into: &hasher)
    }
    
    static func == (lhs: Palette, rhs: Palette) -> Bool {
        lhs.id == rhs.id
    }
    
    static let example: Palette = {
        var palette = Palette()
        
        palette.name = "Example Palette"
        palette.items = [
            PaletteItem(color: .mint, role: .accent),
            PaletteItem(color: .white),
            PaletteItem(color: .gray),
            PaletteItem(color: .green),
            PaletteItem(color: .indigo),
            PaletteItem(color: .blue),
            PaletteItem(color: .purple)
        ]
        return palette
    }()
}
