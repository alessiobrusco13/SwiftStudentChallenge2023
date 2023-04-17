//
//  PaletteEditor.swift
//  My App
//
//  Created by Alessio Garzia Marotta Brusco on 29/03/23.
//

// TODO: Name suggestion view

import SwiftUI

struct PaletteEditor: View {
    @Binding var palette: Palette
    
    @EnvironmentObject private var model: Model
    //    @Environment(\.rename) private var rename
    @Environment(\.dismiss) private var dismiss
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.displayScale) private var displayScale
    
    @State private var selectedItem: PaletteItem?
    @State private var showingReport = false
    @AccessibilityFocusState private var editorFocused: Bool
    
    var sharePreview: SharePreview<Image, Never> {
        SharePreview(palette.name, image: documentImage())
    }
    
    var body: some View {
        GeometryReader { proxy in
            DynamicStack {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], alignment: .center) {
                        ForEach($palette.items) { $item in
                            Button {
                                withAnimation { selectedItem = item }
                            } label: {
                                ColorGridItem(paletteItem: $item)
                            }
                            .buttonStyle(.selectable(isSelected: isSelected(item: item)))
                            .contextMenu {
                                DeleteButton {
                                    withAnimation {
                                        let index = model.index(for: item, in: palette)
                                        palette.items.remove(at: index)
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                }
                
                Spacer(minLength: 0)
                
                // Try using half-sheet with interactive background.
                DynamicStack(spacing: 0) {
                    if horizontalSizeClass == .regular {
                        Divider()
                            .ignoresSafeArea()
                    }
                    
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
                    .frame(maxWidth: horizontalSizeClass == .compact ? nil : 400)
                    .frame(height: horizontalSizeClass == .compact ? proxy.frame(in: .global).height * 0.6 : nil)
                    .compositingGroup()
                    .shadow(color: primaryColorInverted.opacity(0.2), radius: horizontalSizeClass == .compact ? 8 : 0)
                }
            }
        }
        .toolbarRole(.editor)
        .navigationTitle($palette.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(horizontalSizeClass == .compact ? .automatic : .visible, for: .navigationBar)
        .navigationDocument(palette, preview: sharePreview)
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
        .fullScreenCover(isPresented: $showingReport) {
            PaletteReportView(palette: palette)
        }
        .toolbar(id: "paletteEditor") {
            ToolbarItem(id: "add", placement: .primaryAction) {
                Button(action: addItem) {
                    Label("Add color", systemImage: "plus.circle")
                }
            }
        }
        .safeAreaInset(edge: .bottom) {
            Button {
                showingReport.toggle()
            } label: {
                Label("Report", systemImage: "chart.pie")
                    .frame(maxWidth: 150)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.thickMaterial.shadow(.inner(color: .primary.opacity(0.6), radius: 0.3)), lineWidth: 5)
            }
            .frame(maxWidth: .infinity, maxHeight: 66)
        }
        .onChange(of: selectedItem) { _ in
            editorFocused = true
        }
    }
    var primaryColorInverted: Color {
        (colorScheme == .light) ? .white : .black
    }
    
    func selectedItemBinding(unwrappedSelected: PaletteItem) -> Binding<PaletteItem> {
        let index = model.index(for: unwrappedSelected, in: palette)
        
        return Binding<PaletteItem> {
            guard palette.items.indices.contains(index) else { return .init() }
            return palette.items[index]
        } set: { value in
            palette.items[index] = value
        }
    }
    
    func addItem() {
        let name = "Item \(palette.items.count + 1)"
        let item = PaletteItem(name: name)
        
        withAnimation {
            palette.items.append(item)
            selectedItem = item
        }
    }
    
    func isSelected(item: PaletteItem) -> Bool {
        item == selectedItem
    }
    
    @MainActor func documentImage() -> Image {
        let colors = palette.items
            .map(\.color)
            .sorted {
                guard
                    let hsba1 = $0.hsbaComponents,
                    let hsba2 = $1.hsbaComponents
                else {
                    return false
                }
                
                return hsba1.hue < hsba2.hue
            }
        
        let renderer = ImageRenderer(
            content:
                RoundedRectangle(cornerRadius: 3)
                .fill(.linearGradient(colors: colors, startPoint: .topLeading, endPoint: .bottomTrailing))
                .blur(radius: 1)
                .aspectRatio(1, contentMode: .fill)
        )
        
        renderer.scale = displayScale * 100
        renderer.isOpaque = true
        
        if let uiImage = renderer.uiImage {
            return Image(uiImage: uiImage)
        } else {
            return Image(systemName: "questionmark.square")
        }
    }
}

struct PaletteEditor_Previews: PreviewProvider {
    static var previews: some View {
        PaletteEditor(palette: .constant(.example))
            .environmentObject(Model())
    }
}
