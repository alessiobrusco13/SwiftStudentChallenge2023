//
//  MaterialGroupBoxStyle.swift
//  
//
//  Created by Alessio Garzia Marotta Brusco on 17/04/23.
//

import SwiftUI

struct MaterialGroupBoxStyle: GroupBoxStyle {
    let background: Material
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.content
            .padding(.top)
            .padding()
            .background(background.shadow(.inner(color: .primary.opacity(0.8), radius: 0.3)), in: RoundedRectangle(cornerRadius: 10))
            .overlay(alignment: .topLeading) {
                configuration.label
                    .font(.title3.weight(.medium))
                    .padding()
            }
    }
}

extension GroupBoxStyle where Self == MaterialGroupBoxStyle {
    static func material(_ material: Material) -> MaterialGroupBoxStyle {
        MaterialGroupBoxStyle(background: material)
    }
}
