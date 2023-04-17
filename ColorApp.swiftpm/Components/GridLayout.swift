//
//  GridLayout.swift
//  
//
//  Created by Alessio Garzia Marotta Brusco on 17/04/23.
//

import SwiftUI

struct GridLayout: Layout {
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout Void) -> CGSize {
        guard !subviews.isEmpty else { return .zero }
        
        guard let width = proposal.width else { return .zero }
        let maxSize = maxSize(subviews: subviews)
        let maxVerticalSpacing = maxVerticalSpacing(subviews: subviews)
        
        let columns = numberOfColumns(subviews: subviews, width: width)
        if columns == 0 {
            print("Yes")
        }
        
        let rows = subviews.count / (columns != 0 ? columns : 1)
        
        let height = Double(rows) * (maxSize.height + maxVerticalSpacing)
        
        return proposal.replacingUnspecifiedDimensions(by: CGSize(width: width, height: height))
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout Void) {
        guard !subviews.isEmpty else { return }
        
        let maxSize = maxSize(subviews: subviews)
        let horizontalSpacing = maxHorizontalSpacing(subviews: subviews)
        let verticalSpacing = maxVerticalSpacing(subviews: subviews)
        
        let placementProposal = ProposedViewSize(maxSize)
        let columns = numberOfColumns(subviews: subviews, width: bounds.width)
        var point = CGPoint(x: bounds.minX, y: bounds.minY)
        
        for index in subviews.indices {
            subviews[index].place(at: point, anchor: .leading, proposal: placementProposal)
            
            if !(index + 1).isMultiple(of: columns) {
                point.x += maxSize.width + horizontalSpacing
            } else {
                point.x = bounds.minX
                point.y += maxSize.height + verticalSpacing
            }
        }
    }
    
    private func maxSize(subviews: Subviews) -> CGSize {
        let subviewSizes = subviews.map { $0.sizeThatFits(.unspecified) }
        return subviewSizes.reduce(.zero) { currentMax, size in
            CGSize(
                width: max(currentMax.width, size.width),
                height: max(currentMax.height, size.height))
        }
    }
    
    private func maxHorizontalSpacing(subviews: Subviews) -> Double {
        subviews.indices.map { index in
            guard index < subviews.count - 1 else { return 0 }
            return subviews[index].spacing.distance(
                to: subviews[index + 1].spacing,
                along: .horizontal)
        }
        .reduce(0.0) { max($0, $1) }
    }
    
    private func maxVerticalSpacing(subviews: Subviews) -> Double {
        subviews.indices.map { index in
            guard index < subviews.count - 1 else { return 0 }
            return subviews[index].spacing.distance(
                to: subviews[index + 1].spacing,
                along: .vertical)
        }
        .reduce(0.0) { max($0, $1) }
    }
    
    private func numberOfColumns(subviews: Subviews, width: Double) -> Int {
        let maxSize = maxSize(subviews: subviews)
        let maxHorizontalSpacing = maxHorizontalSpacing(subviews: subviews)
        
        print(maxSize.width)
        print(maxHorizontalSpacing)
        print(subviews.count)
        
        return Int(((maxSize.width + maxHorizontalSpacing) * Double(subviews.count) / width).rounded(.down))
    }
}
