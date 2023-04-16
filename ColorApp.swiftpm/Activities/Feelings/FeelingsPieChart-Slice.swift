//
//  FeelingsPieChart-Slice.swift
//  
//
//  Created by Alessio Garzia Marotta Brusco on 16/04/23.
//

import SwiftUI

extension FeelingsPieChart {
    struct SliceView: View {
        let data: FeelingsReport.ChartData
        let center: CGPoint
        let radius: Double
        
        var body: some View {
            ZStack {
                Path { path in
                    path.move(to: center)
                    path.addArc(center: center, radius: radius, startAngle: data.startAngle, endAngle: data.endAngle, clockwise: false)
                    substruct(percent: 0.8, to: &path)
                }
                .fill(.indigo.gradient)
            }
        }
        
        func substruct(percent: Double, to path: inout Path) {
            path = Path(path.cgPath.subtracting(
                Path { path in
                    path.move(to: center)
                    path.addArc(center: center, radius: radius * percent, startAngle: data.startAngle, endAngle: data.endAngle, clockwise: false)
                }.cgPath
            ))
        }
    }
}

struct Slice_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geo in
            let frame = geo.frame(in: .local)
            FeelingsPieChart.SliceView(data: FeelingsReport(palette: .example).chartData.first!, center: CGPoint(x: frame.midX, y: frame.midY), radius: frame.width * 0.5)
        }
    }
}
