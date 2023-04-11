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
                    LazyVGrid(columns: columns, alignment: .center, spacing: 20) {
                        ForEach($model.palettes) { $palette in
                            NavigationLink(value: palette) {
                                PaletteGridItem(palette: $palette)
                                    .transition(.scale)
                                    .contextMenu {
                                        Button(role: .destructive) {
                                            withAnimation {
                                                withAnimation {
                                                    model.delete(palette)
                                                }
                                            }
                                        } label: {
                                            Label("Delete Palette", systemImage: "trash")
                                        }
                                    }
                            }
                        }
                    }
                    .padding(.horizontal)
                    .navigationDestination(for: Palette.self) { palette in
                        PaletteEditor(palette: model.paletteBinding(for: palette))
                    }
                    // Which is more appropriate between 'navigationStack' and 'browser'?
                    //                    .toolbarRole(.browser) 
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
        let newPalette = model.addPalette()
        path.append(newPalette)
    }
}
