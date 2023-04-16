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
            PaletteItem(color: .mint, role: .accent, feeling: .anger),
            PaletteItem(color: .white, feeling: .anger),
            PaletteItem(color: .gray, feeling: .balance),
            PaletteItem(color: .green, feeling: .balance),
            PaletteItem(color: .indigo, feeling: .excitement),
            PaletteItem(color: .blue, feeling: .excitement),
            PaletteItem(color: .purple, feeling: .ecoFriendliness),
            PaletteItem(color: .brown, feeling: .authority)
        ]
        return palette
    }()
}
