import Combine
import Foundation
import SwiftUI


class Model: ObservableObject {
    @Published var palettes: [Palette]
    
    private let savePath = URL.documentsDirectory.appending(path: "SavedPalettes")
    private var saveSubscription: AnyCancellable?
    
    static let tmpURL = FileManager.default.temporaryDirectory.appending(path: "PalettesTMP")
    
    init() {
        do {
            let data = try Data(contentsOf: savePath)
            palettes = try JSONDecoder().decode([Palette].self, from: data)
        } catch {
            palettes = []
        }
        
        saveSubscription = $palettes
            .debounce(for: 5, scheduler: RunLoop.main)
            .sink { [weak self] _ in
                self?.save()
            }
    }
    
    @discardableResult
    func addPalette() -> Palette {
        let palette = Palette()
        palettes.append(palette)
        
        return palette
    }
    
    func paletteBinding(for palette: Palette) -> Binding<Palette> {
        let index = index(for: palette)
        
        return Binding {
            // TODO: Fix this issue.
            // Why do I need this?? I could also not use the navigationDestination API and avoid the issue entierly.
            guard self.palettes.indices.contains(index) else { return Palette() }
            return self.palettes[index]
        } set: { [self] in
            self.palettes[index] = $0
        }
    }
    
    private func index(for palette: Palette) -> Int {
        palettes.firstIndex(of: palette) ?? 0
    }

    func index(for item: PaletteItem, in palette: Palette) -> Int {
        palette.items.firstIndex { $0 == item } ?? 0
    }
    
    private func feelings(for color: ColorRecognizer.Output?) -> [Feeling] {
        guard let color else { return [] }
        
        switch color {
        case .red:
            return [.power, .excitement, .love, .anger]
        case .yellow:
            return [.competence, .happiness, .inexpensiveness]
        case .green:
            return [.ecoFriendliness, .health, .envy, .money, .hope]
        case .blue:
            return [.sophistication, .competence, .corporate, .reliability]
        case .pink:
            return [.authority, .sincerity]
        case .violet, .purple:
            return [.warmth, .sophistication, .power]
        case .orange:
            return [.ruggedness, .excitement]
        case .black:
            return [.happiness, .sophistication, .excitement, .fear]
        case .white:
            return [.sincerity, .purity]
        case .grey:
            return [.neutrality, .balance]
        }
    }
    
    func feelings(for item: PaletteItem) -> [Feeling] {
        let recognizer = ColorRecognizer()
        let color = recognizer.color(for: item)
        return feelings(for: color)
    }
    
    func delete(_ palette: Palette) {
        let index = index(for: palette)
        palettes.remove(at: index)
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(palettes)
            try data.write(to: savePath, options: [.completeFileProtection, .atomic])
        } catch {
            print("Unable to save the data: \(error.localizedDescription)")
        }
    }
}
