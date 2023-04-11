//
//  PaletteEditor.swift
//  My App
//
//  Created by Alessio Garzia Marotta Brusco on 29/03/23.
//

import SwiftUI

struct PaletteEditor: View {
    @Binding var palette: Palette
    
    @EnvironmentObject private var model: Model
    //    @Environment(\.rename) private var rename
    @Environment(\.dismiss) private var dismiss
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    @State private var selectedItem: PaletteItem?
    @State private var showingReport = false
    
    @State private var isRed = false
    
    @AccessibilityFocusState private var editorFocused: Bool
    
    var body: some View {
        DynamicStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], alignment: .center) {
                    ForEach($palette.items) { $item in
                        Button {
                            withAnimation { selectedItem = item }
                            editorFocused = true
                        } label: {
                            ColorGridItem(paletteItem: $item)
                        }
                        .buttonStyle(.selectable(isSelected: isSelected(item: item)))
                    }
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity)
            }
            
            Spacer(minLength: 0)
            
            // Try using half-sheet with interactive background.
            DynamicStack(spacing: 0) {
                Divider()
                    .ignoresSafeArea()
                
                Group {
                    if let selectedItem {
                        EditorSidebar(selection: selectedItemBinding(unwrappedSelected: selectedItem))
                            .accessibilityFocused($editorFocused)
                    } else {
                        Color(.systemGroupedBackground)
                            .ignoresSafeArea()
                            .overlay {
                                Text(
                                    palette.items.isEmpty
                                    ? "Add a new color"
                                    : "Select a color"
                                )
                                .foregroundColor(.secondary)
                                .font(.title.weight(.medium))
                            }
                    }
                }
                .frame(
                    maxWidth: horizontalSizeClass == .compact ? nil : 400,
                    maxHeight: horizontalSizeClass == .compact ? 300 : nil
                )
            }
        }
        .toolbarRole(.editor)
        //        .toolbarBackground(.visible, for: .automatic)
        .navigationTitle($palette.name)
        .navigationBarTitleDisplayMode(.inline)
        .navigationDocument(palette)
        .toolbarTitleMenu {
            // Can't get the 'pencil' icon to show up.
            RenameButton()

            Button(role: .destructive) {
                dismiss()
                model.delete(palette)
            } label: {
                Label("Delete Palette", systemImage: "trash")
            }
        }
        .toolbar(id: "paletteEditor") {
            ToolbarItem(id: "report", placement: .secondaryAction) {
                Button {
                    showingReport.toggle()
                } label: {
                    Label("Palette Report", systemImage: "list.bullet.clipboard")
                }
            }
            
            ToolbarItem(id: "add", placement: .primaryAction) {
                Button(action: addItem) {
                    Label("Add color", systemImage: "plus.circle")
                }
            }
        }
        .sheet(isPresented: $showingReport) {
            PaletteReportView(palette: palette)
        }
        
    }
    
    func selectedItemBinding(unwrappedSelected: PaletteItem) -> Binding<PaletteItem> {
        let index = model.index(for: unwrappedSelected, in: palette)
        
        return Binding<PaletteItem> {
            palette.items[index]
        } set: { value in
            palette.items[index] = value
        }
    }
    
    func addItem() {
        let item = PaletteItem()
        
        withAnimation {
            palette.items.append(item)
            selectedItem = item
        }
    }
    
    func isSelected(item: PaletteItem) -> Bool {
        item == selectedItem
    }
}

struct PaletteEditor_Previews: PreviewProvider {
    static var previews: some View {
        PaletteEditor(palette: .constant(.example))
            .environmentObject(Model())
    }
}
