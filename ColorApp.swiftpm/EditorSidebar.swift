//
//  EditorSidebar.swift
//  My App
//
//  Created by Alessio Garzia Marotta Brusco on 11/04/23.
//

import SwiftUI

struct EditorSidebar: View {
    @Binding var selection: PaletteItem
    @EnvironmentObject private var model: Model
    
    @State private var showingNameField = false
    
    var body: some View {
        Form {
            Section("RGB Editor") {
                RGBSlider(paletteItem: $selection)
                    .padding(8)
            }
            
            Section("Color Info") {
//                Toggle("Choose a name *CHANGE*", isOn: T##Binding<Bool>)
            }
        }
        .onChange(of: selection.id) { _ in
            showingNameField = selection.name != nil
        }
    }
}

struct EditorSidebar_Previews: PreviewProvider {
    static var previews: some View {
        EditorSidebar(selection: .constant(.init()))
    }
}
