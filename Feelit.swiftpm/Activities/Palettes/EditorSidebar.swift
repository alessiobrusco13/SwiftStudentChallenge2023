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
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    var feelings: [Feeling] {
        withAnimation {
            model.feelings(for: selection)
        }
    }
    
    var body: some View {
        Form {
            Section {
                RGBSlider(paletteItem: $selection)
                    .padding(8)
            } header: {
                VStack(alignment: .leading, spacing: 0) {
                    Color.clear
                        .frame(height: 35)
                    
                    Text("RGB Editor")
                }
            }
            
            Section("Feelings Editor") {
                FeelingPicker(selection: $selection.feeling, feelings: feelings)
                    .frame(height: horizontalSizeClass == .compact ? 100 : 145)
                    .padding(.top)
            }
            
            // TODO: Overlay with suggested name.
            Section("Info Editor") {
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
                    
                    Label("Not set", systemImage: "questionmark.square")
                        .tag(Optional<PaletteItem.Role>.none)
                }
            }
        }
        .accessibilityLabel("Inspector")
        .overlay(alignment: .top) {
            Text("Inspector")
                .padding(.horizontal, 20)
                .fontWeight(.medium)
                .fontWidth(.expanded)
                .frame(maxWidth: .infinity, alignment: .center)
                .frame(height: 46)
                .background(.thickMaterial)
                .accessibilityHidden(true)
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
            .environmentObject(Model())
    }
}
