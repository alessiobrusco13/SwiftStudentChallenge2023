//
//  PaletteReportView.swift
//  My App
//
//  Created by Alessio Garzia Marotta Brusco on 30/03/23.
//

import SwiftUI
import Charts

struct PaletteReportView: View {
    let palette: Palette
    
    // TODO: Create a pie chart for the feelings expressed in the palette.
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Chart {
                        BarMark(
                            x: .value("Emotion", "Happiness"),
                            y: .value("Feeling Percent", 30)
                        )
                        
                        BarMark(
                            x: .value("Emotion", "Sadness"),
                            y: .value("Feeling Percent", 20)
                        )
                        
                        BarMark(
                            x: .value("Emotion", "Growth"),
                            y: .value("Feeling Percent", 15)
                        )
                        
                        BarMark(
                            x: .value("Emotion", "Loss"),
                            y: .value("Feeling Percent", 25)
                        )
                        
                        BarMark(
                            x: .value("Emotion", "joy"),
                            y: .value("Feeling Percent", 10)
                        )
                    }
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: 500, alignment: .center)
                } header: {
                    Text("Feelings Chart")
                        .font(.title.weight(.semibold))
                        .foregroundColor(.primary)
                        .textCase(.none)
                }
            }
            .navigationTitle("Palette Report")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct PaletteReportView_Previews: PreviewProvider {
    static var previews: some View {
        PaletteReportView(palette: .example)
    }
}
