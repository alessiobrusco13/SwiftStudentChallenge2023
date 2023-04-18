//
//  ColorItem.swift
//  My App
//
//  Created by Alessio Garzia Marotta Brusco on 30/03/23.
//

import SwiftUI

struct ColorGridItem: View {
    @Binding var paletteItem: PaletteItem
    
    var values: RGBValues {
        paletteItem.color.rgbValues
    }
    
    var body: some View {
        paletteItem.color
            .aspectRatio(1, contentMode: .fill)
            .frame(maxWidth: 150, maxHeight: 150)
            .padding(6)
            .overlay { regularOverlay }
            .compositingGroup()
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.2), radius: 6)
            .accessibilityLabel("Palette Item. red: \(values.red), green: \(values.green), blue: \(values.blue).")
    }
    
    var regularOverlay: some View {
        RoundedRectangle(cornerRadius: 16)
            .strokeBorder(
                .regularMaterial
                .shadow(.inner(color: .primary.opacity(0.6), radius: 0.3))
                , lineWidth: 6
            )
    }
}

struct ColorItem_Previews: PreviewProvider {
    static var previews: some View {
        ColorGridItem(paletteItem: .constant(.init(color: .black)))
    }
}
