//
//  FeelingsPieChart.swift
//  
//
//  Created by Alessio Garzia Marotta Brusco on 15/04/23.
//

import SwiftUI

struct FeelingsPieChart: View {
    let report: FeelingsReport
    
    var chartDescription: String {
        var descripiton = ""
        
        for feeling in report.feelings {
            descripiton.append("\(feeling.text): \(report.formattedPercent(for: feeling)); ")
        }
        
        return descripiton
    }
    
    var body: some View {
        GeometryReader { geo in
            let width = geo.frame(in: .local).width
            
            ForEach(report.chartData, id: \.feeling) { data in
                Slice(data: data, strokeWidth: width * 0.03)
                    .overlay {
                        Text(data.feeling.emoji)
                            .font(.system(size: width * 0.075))
                            .padding(6)
                            .background {
                                Circle()
                                    .fill(.thinMaterial)
                                
                                Circle()
                                    .stroke(.regularMaterial.shadow(.drop(color: .primary.opacity(0.2), radius: 10)), lineWidth: 6)
                            }
                            .offset(offset(data: data, radius: width * 0.5))
                    }
            }
            .overlay {
                Circle()
                    .fill(.thinMaterial)
                    .frame(width: width * 0.549)
                
                if let top = report.topFeelings {
                    VStack(spacing: 10) {
                        Text(
                            top.count == 1
                            ? "The feeling you conveyed the most is:"
                            : "The feelings you conveyed the most are:"
                        )
                        .minimumScaleFactor(0.01)
                        
                        ForEach(top, id: \.self) { feeling in
                            Text(feeling.label)
                                .font(.title3.weight(.medium).width(.expanded))
                                .lineLimit(1)
                                .minimumScaleFactor(0.01)
                                
                        }
                    }
                    .frame(width: width * 0.4, height: width * 0.4)
                    .multilineTextAlignment(.center)
                }
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(chartDescription)
    }
    
    func offset(data: FeelingsReport.ChartData, radius: Double) -> CGSize {
        let angle = (data.startAngle + data.endAngle) / 2
        let multiplier = 0.77
        
        return CGSize(
            width: radius * cos(angle.radians) * multiplier,
            height: radius * sin(angle.radians) * multiplier
        )
    }
}

struct FeelingsPieChart_Previews: PreviewProvider {
    static var previews: some View {
        FeelingsPieChart(report: FeelingsReport(palette: .example))
    }
}
