import SwiftUI

struct PaletteGridItem: View {
    @Environment(\.colorScheme) private var colorScheme
    @Binding var palette: Palette
    
    
    var items: [PaletteItem] {
        guard palette.items.count > 6 else { return palette.items }
        return (0...4).map { palette.items[$0] }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                ForEach(items) { item in
                    item.color
                        .frame(minHeight: 80)
                }
                
                if items.isEmpty {
                    Color(.systemGroupedBackground)
                        .frame(minHeight: 80)
                }
                
                if items.count == 5 {
                    Color(.systemGroupedBackground)
                        .frame(minHeight: 80)
                        .overlay {
                            Image(systemName: "ellipsis")
                                .font(.largeTitle)
                        }
                }
            }
            .background(Color(.systemGroupedBackground))
            .padding(6)
            .overlay {
                RoundedRectangle(cornerRadius: 16)
                    .strokeBorder(
                        .regularMaterial
                        .shadow(.inner(color: .primary, radius: 0.3))
                        , lineWidth: 6
                    )
            }
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.2), radius: 6)
            .frame(maxWidth: 500)
            
            HStack(spacing: 1) {
                Text(palette.name)
                    .font(.headline.width(.expanded))
                    .foregroundColor(.primary)
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.secondary)
                    .fontWeight(.medium)
            }
            .padding(5)
            .padding(.leading, 3)
        }
        .compositingGroup()
    }
}

struct PaletteGridItem_Previews: PreviewProvider {
    static var previews: some View {
        PaletteGridItem(palette: .constant(.example))
            .padding()
    }
}
