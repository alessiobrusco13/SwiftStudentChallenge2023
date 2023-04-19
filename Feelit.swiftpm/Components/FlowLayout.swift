import SwiftUI

struct FlowLayout: Layout {
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout Void) -> CGSize {
        proposal.replacingUnspecifiedDimensions()
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout Void) {
        guard !subviews.isEmpty else { return }
        var point = CGPoint(x: bounds.minX, y: bounds.minY)
        
        let horizontalSpacing = horizontalSpacing(subviews: subviews)
        let verticalSpacing = maxVerticalSpacing(subviews: subviews)
        
        for index in subviews.indices {
            let size = subviews[index].sizeThatFits(.unspecified)
            let placementProposal = ProposedViewSize(size)
            
            subviews[index].place(at: point, anchor: .leading, proposal: placementProposal)
            
            guard index < subviews.count - 1 else { break }
            
            let newX = point.x + size.width
            let followingSize = subviews[index + 1].sizeThatFits(.unspecified)
            
            if newX + followingSize.width > bounds.maxX {
                point.x = bounds.minX
                point.y += verticalSpacing + followingSize.height
            } else {
                point.x = newX + horizontalSpacing[index]
            }
        }
    }
    
    private func horizontalSpacing(subviews: Subviews) -> [CGFloat] {
        subviews.indices.map { index in
            guard index < subviews.count - 1 else { return 0 }
            return subviews[index].spacing.distance(to: subviews[index + 1].spacing, along: .horizontal)
        }
    }
    
    private func maxVerticalSpacing(subviews: Subviews) -> CGFloat {
        let spacing: [CGFloat] = subviews.indices.map { index in
            guard index < subviews.count - 1 else { return 0 }
            return subviews[index].spacing.distance(to: subviews[index + 1].spacing, along: .vertical)
        }
        
        guard let max = spacing.max() else { return 0 }
        return max
    }
}
