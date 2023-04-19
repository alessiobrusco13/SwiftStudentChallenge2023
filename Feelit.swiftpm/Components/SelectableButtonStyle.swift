import SwiftUI

struct SelectableButtonStyle: ButtonStyle {
    var isSelected: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .overlay {
                if isSelected {
                    RoundedRectangle(cornerRadius: 16)
                        .strokeBorder(Color.accentColor, lineWidth: 6)
                }
            }
    }
}

extension ButtonStyle where Self == SelectableButtonStyle {
    static func selectable(isSelected: Bool) -> SelectableButtonStyle {
        SelectableButtonStyle(isSelected: isSelected)
    }
}

struct SelectableButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Button(action: { print("Pressed") }) {
            Label("Press Me", systemImage: "star")
        }
        .buttonStyle(SelectableButtonStyle(isSelected: true))
    }
}
