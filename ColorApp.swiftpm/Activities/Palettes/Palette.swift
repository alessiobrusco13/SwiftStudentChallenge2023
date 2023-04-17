import SwiftUI

struct Palette: Identifiable, Codable, Hashable, Transferable {
    var id = UUID()
    var name = "Untitled"
    var items = [PaletteItem]()
    
    // want to represent it as a folder of colours.
    static var transferRepresentation: some TransferRepresentation {
        FileRepresentation(exportedContentType: .zip) { palette in
            let tempDirectory = Model.tmpURL.appending(path: "\(palette.name)–\(UUID().uuidString)")
            try FileManager.default.createDirectory(at: tempDirectory, withIntermediateDirectories: false)
            
            let finalURL = Model.tmpURL.appending(path: "\(palette.name)–\(UUID().uuidString).zip")
            
            for item in palette.items {
                let data =  await item.jpgRepresentation()
                try data.write(to: tempDirectory.appending(path: "\(item.name).jpg"))
            }
            
            let coordinator = NSFileCoordinator()
            var error: NSError?
            
            coordinator.coordinate(readingItemAt: tempDirectory, options: [.forUploading], error: &error) { zipURL in
                do {
                    try FileManager.default.moveItem(at: zipURL, to: finalURL)
                } catch {
                    print(error.localizedDescription)
                }
            }
            
            return SentTransferredFile(finalURL)
        }
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
