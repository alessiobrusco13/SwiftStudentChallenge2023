//
//  FeelingPicker.swift
//  My App
//
//  Created by Alessio Garzia Marotta Brusco on 13/04/23.
//

import SwiftUI

struct FeelingPicker: View {
    @Binding var selection: Feeling?
    let feelings: [Feeling]
    
    @Namespace private var namespace
    @State private var showingMore = false
    
    var moreFeelings: [Feeling] {
        var shown = Set(feelings)
        
        if let selection, !feelings.contains(selection) {
            shown.insert(selection)
        }
        
        return Set(Feeling.allCases)
            .subtracting(shown)
            .sorted { $0.text < $1.text}
    }
    
    var body: some View {
        FlowLayout {
            if let selection {
                button(for: selection)
                    .tint(.accentColor)
                    .accessibilityAddTraits(.isSelected)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(style: .init(lineWidth: 5, lineCap: .round, lineJoin: .round, dash: [6]))
                            .fill(Color.accentColor)
                            .matchedGeometryEffect(id: "SelectionRectangle", in: namespace)
                    }
            } else {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(style: .init(lineWidth: 5, lineCap: .round, lineJoin: .round, dash: [6]))
                    .fill(Color.accentColor)
                    .frame(width: 100, height: 30)
                    .matchedGeometryEffect(id: "SelectionRectangle", in: namespace)
            }

            ForEach(feelings, id: \.self) { feeling in
                if feeling != selection {
                    button(for: feeling)
                }
            }
            
            Button {
                showingMore.toggle()
            } label: {
                HStack {
                    Text("More")
                    Image(systemName: "chevron.right")
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .sheet(isPresented: $showingMore) {
            MoreFeelingsView(feelings: moreFeelings, selection: $selection)
                .presentationDetents([.medium])
        }
    }
    
    func button(for feeling: Feeling) -> some View {
        Button {
            toggleSelection(feeling: feeling)
        } label: {
            Text(feeling.label)
        }
        .buttonStyle(.bordered)
        .matchedGeometryEffect(id: feeling, in: namespace)
        .accessibilityLabel(feeling.text)
    }
    
    func toggleSelection(feeling: Feeling) {
        withAnimation {
            if selection == feeling {
                selection = nil
            } else {
                selection = feeling
            }
        }
    }
}

struct FeelingPicker_Previews: PreviewProvider {
    static var previews: some View {
        FeelingPicker(selection: .constant(.anger), feelings: [.anger, .authority, .balance, .corporate, .excitement, .happiness])
    }
}
