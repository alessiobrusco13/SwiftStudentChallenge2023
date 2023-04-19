import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var model: Model
    @State private var path = NavigationPath()
    
    var columns: [GridItem] {
        [GridItem(.adaptive(minimum: 360), spacing: 20)]
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                BackgroundView()
                
                ScrollView {
                    if model.palettes.isEmpty {
                        Text("Create a new Palette to Feel It")
                            .foregroundColor(.secondary)
                            .font(.title3.weight(.medium).width(.expanded))
                            .padding()
                            .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 10))
                            .padding(.top, 75)
                    }
                    
                    LazyVGrid(columns: columns, alignment: .center, spacing: 20) {
                        ForEach($model.palettes) { $palette in
                            NavigationLink(value: palette) {
                                PaletteGridItem(palette: $palette)
                                    .transition(.scale)
                                    .contextMenu {
                                        DeleteButton("Delete Palette") {
                                            withAnimation {
                                                model.delete(palette)
                                            }
                                        }
                                    }
                            }
                        }
                    }
                    .padding(.horizontal)
                    .navigationDestination(for: Palette.self) { palette in
                        PaletteEditor(palette: model.paletteBinding(for: palette))
                    }
                    .toolbar {
                        Button(action: addPalette) {
                            Label("Add Palette", systemImage: "plus")
                                .font(.title3)
                        }
                    }
                }
                .navigationTitle("Palettes")
            }
        }
    }
    
    func addPalette() {
        withAnimation {
            let newPalette = model.addPalette()
            path.append(newPalette)
        }
    }
}
