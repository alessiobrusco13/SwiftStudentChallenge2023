//
//  MoreFeelingsView.swift
//  
//
//  Created by Alessio Garzia Marotta Brusco on 15/04/23.
//

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
            // TODO: Reivew text.
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
                Button(action: dismiss.callAsFunction) {
                    Label("Dismiss", systemImage: "xmark")
                        .font(.footnote.weight(.semibold).width(.expanded))
                        .foregroundColor(.primary)
                        .padding(8)
                        .background(.thickMaterial)
                        .clipShape(Circle())
                }
            }
        }
    }
}

struct MoreFeelingsView_Previews: PreviewProvider {
    static var previews: some View {
        MoreFeelingsView(feelings: Feeling.allCases, selection: .constant(nil))
    }
}
