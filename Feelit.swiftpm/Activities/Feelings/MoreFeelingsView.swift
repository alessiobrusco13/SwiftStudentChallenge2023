import SwiftUI

struct MoreFeelingsView: View {
    let feelings: [Feeling]
    @Binding var selection: Feeling?
    
    @State private var showingAlert = false
    @State private var selectedFeeling: Feeling?
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                FlowLayout {
                    ForEach(feelings, id: \.self) { feeling in
                        Button {
                            selectedFeeling = feeling
                            showingAlert.toggle()
                        } label: {
                            Text(feeling.label)
                        }
                        .buttonStyle(.bordered)
                        .accessibilityLabel(feeling.text)
                    }
                }
                .padding()
            }
            .navigationTitle("More feelings...")
            .navigationBarTitleDisplayMode(.inline)
            .alert(
                "Warning",
                isPresented: $showingAlert,
                presenting: selectedFeeling
            ) { feeling in
                Button("OK", role: .destructive) {
                    withAnimation {
                        selection = feeling
                    }
                    
                    dismiss()
                }
                
                Button("Cancel", role: .cancel) { dismiss() }
            } message: { feeling in
                Text("The color you created may not convey \(feeling.text.lowercased()).")
            }
            .toolbar {
                DismissButton()
            }
        }
    }
}

struct MoreFeelingsView_Previews: PreviewProvider {
    static var previews: some View {
        MoreFeelingsView(feelings: Feeling.allCases, selection: .constant(nil))
    }
}
