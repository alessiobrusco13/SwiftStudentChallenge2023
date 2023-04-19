import SwiftUI

struct Blob: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.54072*width, y: 0.00132*height))
        path.addCurve(to: CGPoint(x: 0.96317*width, y: 0.29206*height), control1: CGPoint(x: 0.72318*width, y: -0.01437*height), control2: CGPoint(x: 0.87632*width, y: 0.13946*height))
        path.addCurve(to: CGPoint(x: 0.93616*width, y: 0.69612*height), control1: CGPoint(x: 1.03432*width, y: 0.41707*height), control2: CGPoint(x: 0.98564*width, y: 0.56207*height))
        path.addCurve(to: CGPoint(x: 0.7174*width, y: 0.95779*height), control1: CGPoint(x: 0.89538*width, y: 0.80657*height), control2: CGPoint(x: 0.82801*width, y: 0.90545*height))
        path.addCurve(to: CGPoint(x: 0.35799*width, y: 0.96967*height), control1: CGPoint(x: 0.6046*width, y: 1.01116*height), control2: CGPoint(x: 0.47722*width, y: 1.00855*height))
        path.addCurve(to: CGPoint(x: 0.0066*width, y: 0.72606*height), control1: CGPoint(x: 0.21354*width, y: 0.92258*height), control2: CGPoint(x: 0.04179*width, y: 0.8667*height))
        path.addCurve(to: CGPoint(x: 0.20475*width, y: 0.3573*height), control1: CGPoint(x: -0.02873*width, y: 0.58489*height), control2: CGPoint(x: 0.11704*width, y: 0.4763*height))
        path.addCurve(to: CGPoint(x: 0.54072*width, y: 0.00132*height), control1: CGPoint(x: 0.30593*width, y: 0.22001*height), control2: CGPoint(x: 0.36453*width, y: 0.01648*height))
        path.closeSubpath()
        return path
    }
}
