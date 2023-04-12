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
    @FocusState private var nameFocused: Bool
    
    @State private var isScrolling = false
    
    var body: some View {
        Form {
            Section {
                RGBSlider(paletteItem: $selection)
                    .padding(8)
                
                Text(String(describing: isScrolling))
            } header: {
                VStack(alignment: .leading, spacing: 0) {
                    Color.clear
                        .frame(height: 35)
                    
                    Text("RGB Editor")
                }
            }
            
            // TODO: Overlay with suggested name
            Section {
                LabeledContent("**Name:**") {
                    TextField("e.g. Red", text: $selection.name)
                        .multilineTextAlignment(.trailing)
                        .focused($nameFocused)
                }
                
                Picker("**Role:**", selection: $selection.role) {
                    ForEach(PaletteItem.Role.allCases, id: \.self) { role in
                        Label(String(describing: role).capitalized, systemImage: role.sfSymbol)
                            .tag(Optional(role))
                    }
                    
                    Label("Not Set", systemImage: "questionmark.app")
                        .tag(Optional<PaletteItem.Role>.none)
                }
            } header: {
                HStack {
                    Text("Info Editor")
                    
                    Spacer()
                    
                    Button {
                        print("Hello")
                    } label: {
                        Label("Info", systemImage: "info.circle")
                            .labelStyle(.iconOnly)
                    }
                }
            }
        }
        // TODO: Figure out how to update the background. it sucks.
        .overlay(alignment: .top) {
            Text("Inspector")
                .padding(.horizontal, 20)
                .fontWeight(.medium)
                .fontWidth(.expanded)
                .frame(maxWidth: .infinity, alignment: .center)
                .frame(height: 46)
                .background(.thickMaterial)
        }
        .toolbar {
            if nameFocused {
                ToolbarItem(placement: .keyboard) {
                    Button("Done") {
                        nameFocused = false
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
        }
    }
}

struct EditorSidebar_Previews: PreviewProvider {
    static var previews: some View {
        EditorSidebar(selection: .constant(.init()))
    }
}
