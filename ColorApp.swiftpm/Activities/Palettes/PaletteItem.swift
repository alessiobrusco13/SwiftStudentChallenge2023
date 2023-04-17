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
    
    @MainActor func jpgRepresentation() -> Data {
        let rgb = color.rgbValues
        
        let view = HStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(color)
                .frame(width: 300, height: 300)
                .overlay {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(.thickMaterial, lineWidth: 6)
                }
            
            VStack(alignment: .trailing) {
                Text(name)
                
                Text("Red: \(rgb.red) Green: \(rgb.green) Blue: \(rgb.blue)")
                
                if let feeling {
                    Text(feeling.label)
                }
            }
        }
            .padding()
        
        let renderer = ImageRenderer(content: view)
        renderer.scale = UIScreen.main.scale
        renderer.proposedSize = ProposedViewSize(CGSize(width: 1080, height: 1080))
        
        let uiimage = renderer.uiImage
        if let pngData = uiimage?.jpegData(compressionQuality: 2) {
            return pngData
        } else {
            return .init()
        }
        
    }
}

extension PaletteItem {
    init(colorName: ColorName) {
        self.init(color: Color(rgb: colorName.rgbValues), name: colorName.name)
    }
}
