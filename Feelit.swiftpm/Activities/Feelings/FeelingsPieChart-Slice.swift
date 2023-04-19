import SwiftUI

struct SliceShape: InsettableShape {
    let startAngle: Angle
    let endAngle: Angle
    
    var insetAmount = 0.0
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            let center = CGPoint(x: rect.midX, y: rect.midY)
            let radius = (rect.width * 0.5) - insetAmount
            path.move(to: center)
            path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
            
            path = Path(path.cgPath.symmetricDifference(
                Path { path in
                    path.move(to: center)
                    path.addArc(center: center, radius: radius * 0.6, startAngle: startAngle, endAngle: endAngle, clockwise: false)
                }.cgPath
            ))
        }
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var slice = self
        slice.insetAmount += amount
        return slice
    }
}

extension FeelingsPieChart {
    struct Slice: View {
        let data: FeelingsReport.ChartData
        let strokeWidth: Double
        
        var body: some View {
            Group {
                if data.colors.count > 1 {
                    SliceShape(startAngle: data.startAngle, endAngle: data.endAngle)
                        .fill(.conicGradient(colors: data.colors, center: .center))
                } else if let first = data.colors.first {
                    SliceShape(startAngle: data.startAngle, endAngle: data.endAngle)
                        .fill(first.gradient)
                }
            }
            .overlay {
                SliceShape(startAngle: data.startAngle, endAngle: data.endAngle)
                    .strokeBorder(
                        .regularMaterial,
                        style: StrokeStyle(lineWidth: strokeWidth, lineJoin: .round)
                    )
            }
        }
    }
}

struct Slice_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            FeelingsPieChart.Slice(data: FeelingsReport(palette: .example)!.chartData.first!, strokeWidth: 10)
        }
    }
}
