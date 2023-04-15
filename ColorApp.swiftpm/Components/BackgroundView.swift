//
//  BackgroundView.swift
//  My App
//
//  Created by Alessio Garzia Marotta Brusco on 29/03/23.
//

import SwiftUI

struct BackgroundView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var bottomColors: [Color] {
        if colorScheme == .light {
            return [.mint, .indigo, .mint]
        } else {
            return [.purple, .indigo, .black]
        }
    }
    
    var topColors: [Color] {
        [(colorScheme == .light ? .orange : .red), .indigo, .pink]
    }
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Blob()
                    .fill(.conicGradient(colors: bottomColors, center: .center))
                    .aspectRatio(contentMode: .fit)
                    .blur(radius: 150)
                    .frame(maxWidth: 800, maxHeight: 800)
                    .position(
                        x: proxy.frame(in: .global).width * 0.8,
                        y: proxy.frame(in: .global).height * 0.7
                    )
                
                Blob()
                    .fill(.conicGradient(colors: topColors, center: .center))
                    .aspectRatio(contentMode: .fit)
                    .blur(radius: 150)
                    .frame(maxWidth: 400, maxHeight: 400)
                    .position(
                        x: proxy.frame(in: .global).width * 0.1,
                        y: proxy.frame(in: .global).height * 0.2
                    )
                
            }
        }
        .ignoresSafeArea()
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
