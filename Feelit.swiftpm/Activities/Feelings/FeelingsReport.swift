import SwiftUI

struct FeelingsReport {
    struct ChartData {
        let feeling: Feeling
        let startAngle: Angle
        let endAngle: Angle
        let colors: [Color]
        let percent: Double
    }
    
    private let feelingPercents: [Feeling: Double]
    private let itemsForFeeling: [Feeling: [PaletteItem]]
    
    let feelingItems: [PaletteItem]
    let feelinglessItems: [PaletteItem]
    
    var feelings: [Feeling] {
        Array(feelingPercents.keys).sorted { $0.text < $1.text }
    }
    
    var chartData: [ChartData] {
        var data = [ChartData]()
        var angle = Angle.zero
        
        for feeling in feelings {
            let percent = percent(for: feeling)
            let delta = Angle.degrees(360 * percent)
            let colors = items(for: feeling).map(\.color)
            
            data.append(ChartData(
                feeling: feeling,
                startAngle: angle,
                endAngle: angle + delta,
                colors: colors,
                percent: percent
            ))
            
            angle += delta
        }
                
        return data
    }
    
    var topFeelings: [Feeling]? {
        guard Set(feelingPercents.values).count > 1 else { return nil }
        guard let max = feelingPercents.values.max() else { return nil }
        return feelingPercents.keys
            .filter { feelingPercents[$0] == max }
            .sorted { $0.text < $1.text }
    }
    
    // Max score 10
    var coherenceScore: Int {
        guard feelings.count > 1 else { return 10 }
        
        let pairs = feelings.combinations(ofCount: 2).filter { $0[0] != $0[1] }
        let inconsistent = pairs.filter { !Feeling.areConsistent($0[0], $0[1]) }
        let unformatted = 10 - (10 * (Double(inconsistent.count) / Double(pairs.count)))
        
        return Int(unformatted.rounded())
    }
    
    init?(palette: Palette) {
        guard !palette.items.map(\.feeling).compactMap({ $0 }).isEmpty else { return nil }
        
        var feelingItems = [PaletteItem]()
        var feelinglessItems = [PaletteItem]()
        
        var itemsForFeeling = [Feeling: [PaletteItem]]()
        
        for item in palette.items {
            guard let feeling = item.feeling else {
                feelinglessItems.append(item)
                continue
            }
            
            if itemsForFeeling[feeling] != nil {
                itemsForFeeling[feeling]!.append(item)
            } else {
                itemsForFeeling[feeling] = [item]
            }
            
            feelingItems.append(item)
        }
        
        feelingPercents = itemsForFeeling
            .mapValues { Double($0.count) / Double(feelingItems.count) }
        
        self.feelinglessItems = feelinglessItems
        self.feelingItems = feelingItems
        self.itemsForFeeling = itemsForFeeling
    }
    
    func items(for feeling: Feeling) -> [PaletteItem] {
        itemsForFeeling[feeling, default: []]
            .sorted {
                guard
                    let (h1, _, _, _) = $0.color.hsbaComponents,
                    let (h2, _, _, _) = $1.color.hsbaComponents
                else {
                    return false
                }
                
                return h1 < h2
            }
    }
    
    func percent(for feeling: Feeling) -> Double {
        feelingPercents[feeling, default: 0]
    }
    
    func formattedPercent(for feeling: Feeling) -> String {
        ((percent(for: feeling) * 100).rounded() / 100).formatted(.percent)
    }
}
