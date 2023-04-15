import Foundation

enum RGB {
    case r, g, b
    
    var description: String {
        String(describing: self).uppercased()
    }
    
    var expandedDescription: String {
        switch self {
        case .r:
            return "Red"
        case .g:
            return "Green"
        case .b:
            return "Blue"
        }
    }
}
