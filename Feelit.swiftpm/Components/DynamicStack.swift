import SwiftUI

struct DynamicStack<Content: View>: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    var spacing: CGFloat?
    @ViewBuilder let content: () -> Content
    
    var body: some View {
        let layout = horizontalSizeClass == .compact ? AnyLayout(VStackLayout(spacing: spacing)) : AnyLayout(HStackLayout(spacing: spacing))
        
        layout {
            content()
        }
    }
}

struct DynamicStack_Previews: PreviewProvider {
    static var previews: some View {
        DynamicStack {
            Text("helòlo")
        }
    }
}
