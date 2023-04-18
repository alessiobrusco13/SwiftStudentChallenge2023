//
//  DismissButton.swift
//  
//
//  Created by Alessio Garzia Marotta Brusco on 17/04/23.
//

import SwiftUI

struct DismissButton: View {
    var accessibilityLabel = "Dismiss"
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Button(action: dismiss.callAsFunction) {
            Label(accessibilityLabel, systemImage: "xmark")
                .font(.footnote.weight(.semibold).width(.expanded))
                .foregroundColor(.primary)
                .padding(8)
                .background(.ultraThickMaterial)
                .clipShape(Circle())
        }
    }
}

struct DismissButton_Previews: PreviewProvider {
    static var previews: some View {
        DismissButton()
    }
}
