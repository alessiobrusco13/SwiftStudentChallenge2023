import Foundation

enum Feeling: Codable, CaseIterable, Hashable {
    case power, excitement, love, anger, competence, happiness, lowQuality, ecoFriendliness, health, sophistication, corporate, reliability, authority, sincerity, warmth, ruggedness, fear, expensiveness, purity, neutrality, balance, inexpensiveness, envy, money, hope
    
    var label: String {
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
            return "replace"
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
