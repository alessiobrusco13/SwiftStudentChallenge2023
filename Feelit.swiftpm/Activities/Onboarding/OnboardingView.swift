//
//  OnboardingView.swift
//  
//
//  Created by Alessio Garzia Marotta Brusco on 18/04/23.
//

import SwiftUI

struct OnboardingView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    @State private var selection = 0
    @Namespace private var namespace
    
    var title: some View {
        (
            Text("Welcome to ")
            +
            Text("Feel It")
                .foregroundColor(.accentColor)
                .fontWeight(.heavy)
        )
        .font(.largeTitle.weight(.semibold).width(.expanded))
        .matchedGeometryEffect(id: "title", in: namespace)
    }
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            VStack {
                Spacer()
                
                RoundedRectangle(cornerRadius: 16)
                    .fill(.thinMaterial)
                    .frame(maxWidth: horizontalSizeClass == .regular ? 600 : .infinity, maxHeight: 600)
                    .overlay {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.thickMaterial.shadow(.inner(radius: 1)), lineWidth: 6)
                    }
                    .overlay {
                        TabView(selection: $selection) {
                            VStack(spacing: 30) {
                                if selection == 0 { title }
                                
                                Text("A new way to \(Text("feel").fontWidth(.expanded).fontWeight(.bold)) color")
                                    .font(.title2.weight(.medium))
                                    .foregroundColor(.secondary)
                            }
                            .tag(0)
                            
                            VStack {
                                if selection == 1 { title }
                                
                                Spacer()
                            }
                            .padding(.top, 30
)
                            .tag(1)
                            
                            
                        }
                        .tabViewStyle(.page(indexDisplayMode: .never))
                    }
                
                Spacer()
                
                Button {
//                    guard selection != **PENULTIMATE SELECTION** else { return }
                    withAnimation(.spring()) {
                        selection += 1
                    }
                } label: {
                    Text("Continue")
                        .frame(maxWidth: 250)
                }
                .controlSize(.large)
                .buttonStyle(.borderedProminent)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.thickMaterial.shadow(.inner(radius: 1)), lineWidth: 4)
                }
            }
            .padding()
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
