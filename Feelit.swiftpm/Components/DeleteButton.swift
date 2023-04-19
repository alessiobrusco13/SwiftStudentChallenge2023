import SwiftUI

struct DeleteButton: View {
    let label: String
    let action: () -> Void
    
    init(_ label: String = "Delete", action: @escaping () -> Void) {
        self.label = label
        self.action = action
    }
    
    var body: some View {
        Button(role: .destructive, action: action) {
            Label(label, systemImage: "trash")
        }
    }
}

struct DeleteButton_Previews: PreviewProvider {
    static var previews: some View {
        DeleteButton("Delete") {
            
        }
    }
}
