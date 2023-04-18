import Foundation

enum Feeling: Codable, CaseIterable, Hashable {
    case power, excitement, love, anger, competence, happiness, lowQuality, ecoFriendliness, health, sophistication, corporate, reliability, authority, sincerity, warmth, ruggedness, fear, expensiveness, purity, neutrality, balance, inexpensiveness, envy, money, hope
    
    static func areConsistent(_ feeling1: Feeling, _ feeling2: Feeling) -> Bool {
        if Feeling.neutralGroup.contains(feeling1) || Feeling.neutralGroup.contains(feeling2) { return true }
        let set = Set([feeling1, feeling2])
        
        if set.isSubset(of: Feeling.group1) || set.isSubset(of: Feeling.group2) {
            return true
        }
        
        return false
    }
    
    static let group1: Set<Feeling> = [.excitement, .love, .happiness, .sincerity, .warmth, .hope, .ecoFriendliness, .reliability, .balance, .health]
    static let group2: Set<Feeling> = [.power, .anger, .fear, .envy, .lowQuality]
    static let neutralGroup: Set<Feeling> = [.neutrality, .inexpensiveness, .expensiveness, .ruggedness, .purity, .money, .corporate, .authority, .sophistication, .reliability, .health, .corporate]
    
    var label: String {
        "\(emoji) \(text)"
    }
    
    var text: String {
        switch self {
        case .lowQuality:
            return "Low Quality"
        case .ecoFriendliness:
            return "Eco-Friendliness"
        default:
            return String(describing: self).capitalized
        }
    }
    
    var emoji: String {
        switch self {
        case .power:
            return "💪"
        case .excitement:
            return "🥳"
        case .love:
            return "❤️"
        case .anger:
            return "😡"
        case .competence:
            return "👩‍🔧"
        case .happiness:
            return "😊"
        case .lowQuality:
            return "🧻"
        case .ecoFriendliness:
            return "🌱"
        case .health:
            return "🩺"
        case .sophistication:
            return "🤵‍♂️"
        case .corporate:
            return "👨‍💼"
        case .reliability:
            return "🔐"
        case .authority:
            return "🧑‍⚖️"
        case .sincerity:
            return "😇"
        case .warmth:
            return "🌤️"
        case .ruggedness:
            return "🔨"
        case .fear:
            return "😱"
        case .expensiveness:
            return "💎"
        case .purity:
            return "🌷"
        case .neutrality:
            return "😐"
        case .balance:
            return "⚖️"
        case .inexpensiveness:
            return "💵"
        case .envy:
            return "🤤"
        case .money:
            return "🤑"
        case .hope:
            return "🤞"
        }
    }
}
