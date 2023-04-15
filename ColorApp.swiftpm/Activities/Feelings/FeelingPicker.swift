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
    
    var body: some View {
        FlowLayout {
            RoundedRectangle(cornerRadius: 10)
                .stroke(style: .init(lineWidth: 5, lineCap: .round, lineJoin: .round, dash: [6]))
                .fill(Color.accentColor)
                .frame(width: 100, height: 30)

            ForEach(feelings, id: \.self) { feeling in
                Button {
                    selection = feeling
                } label: {
                    label(for: feeling)
                }
                .buttonStyle(.bordered)
                .tint(selection ==  feeling ? .accentColor : .none)
            }
        }
    }
    
    func label(for feeling: Feeling) -> some View {
        Label {
            Text(feeling.label)
        } icon: {
            Text(feeling.emoji)
        }
    }
}

struct FeelingPicker_Previews: PreviewProvider {
    static var previews: some View {
        FeelingPicker(selection: .constant(.anger), feelings: [.anger, .authority, .balance, .corporate, .excitement, .happiness])
    }
}
