import Combine
import SwiftUI

extension RGBSlider {
    struct SliderComponent: View {
        let value: RGB
        @Binding var rgb: RGBValues
        @Binding var paletteItem: PaletteItem
        
        @State private var offset = 0.0
        @Environment(\.colorScheme) private var colorScheme
        
        var gradient: [Color] {
            switch value {
            case .r:
                return [
                    Color(red: 0, green: rgb.doubleValues.green, blue: rgb.doubleValues.blue),
                    Color(red: 1, green: rgb.doubleValues.green, blue: rgb.doubleValues.blue)
                ]
            case .g:
                return [
                    Color(red: rgb.doubleValues.red, green: 0, blue: rgb.doubleValues.blue),
                    Color(red: rgb.doubleValues.red, green: 1, blue: rgb.doubleValues.blue)
                ]
            case .b:
                return [
                    Color(red: rgb.doubleValues.red, green: rgb.doubleValues.green, blue: 0),
                    Color(red: rgb.doubleValues.red, green: rgb.doubleValues.green, blue: 1)
                ]
            }
        }
        
        var body: some View {
            GeometryReader { geo in
                ZStack {
                    Capsule()
                        .fill(.linearGradient(colors: gradient, startPoint: .leading, endPoint: .trailing))
                        .padding(1)
                        .background {
                            Capsule()
                                .stroke(.regularMaterial.shadow(.drop(color: primaryColorInverted, radius: 2)), lineWidth: 4)
                                .blur(radius: 1)
                        }
                        .overlay(alignment: .leading) {
                            Circle()
                                .stroke(.regularMaterial.shadow(.drop(color: primaryColorInverted, radius: 2)), lineWidth: 6)
                                .padding(1)
                                .overlay {
                                    Text(value.description)
                                        .font(.system(.callout, design: .rounded, weight: .heavy))
                                        .foregroundStyle(.regularMaterial)
                                }
                                .contentShape(.dragPreview, Circle())
                                .offset(x: offset)
                                .gesture(drag(geo))
                        }
                    
                }
                .onAppear {
                    updateOffset(geo)
                }
                .onChange(of: sliderValue()) { _ in
                    withAnimation(.spring()) {
                        updateOffset(geo)
                    }
                }
                .onChange(of: geo.frame(in: .global)) { _ in updateOffset(geo) }
                .accessibilityElement(children: .contain)
                .accessibilityRepresentation {
                    Slider(value: accessibilityBinding, in: 0...255) {
                        Text("\(value.expandedDescription) Slider")
                    }
                    .accessibilityValue(accessibilityValue)
                }
            }
            .frame(height: 30)
        }
        
        var primaryColorInverted: Color {
            (colorScheme == .light) ? .white : .black
        }
        
        @discardableResult
        func sliderValue(action: ((inout Int) -> Void)? = nil) -> Int {
            switch value {
            case .r:
                action?(&rgb.red)
                return rgb.red
            case .g:
                action?(&rgb.green)
                return rgb.green
            case .b:
                action?(&rgb.blue)
                return rgb.blue
            }
            
        }
        
        var accessibilityBinding: Binding<Double> {
            Binding {
                Double(sliderValue())
            } set: { newValue in
                sliderValue { value in
                    value = Int(newValue.rounded())
                }
            }
        }
        
        func colorValue(maxWidth: Double, offset: Double) -> Int {
            // offset : width = color : 255
            Int(((offset * 255.0) / maxWidth).rounded())
        }
        
        func drag(_ proxy: GeometryProxy) -> some Gesture {
            let width = proxy.frame(in: .local).width
            
            return DragGesture()
                .onChanged { value in
                    withAnimation(.spring()) {
                        let newOffset = value.startLocation.x + (value.translation.width)
                        
                        let maxWidth = width - 30
                        
                        if newOffset < maxWidth && newOffset > 0 {
                            offset = newOffset
                            withAnimation(.none) {
                                _ = sliderValue { value in
                                    let colorValue = colorValue(maxWidth: maxWidth, offset: offset)
                                    
                                    if colorValue < 10 {
                                        value = 0
                                    } else if colorValue > 245  {
                                        value = 255
                                    } else {
                                        value = colorValue
                                    }
                                }
                            }
                        }
                    }
                }
        }
        
        func updateOffset(_ proxy: GeometryProxy) {
            let componentValue = sliderValue()
            let maxWidth = proxy.frame(in: .local).width - 30
            
            offset = (Double(componentValue) / 255.0) * maxWidth
        }
        
        var accessibilityValue: String {
            sliderValue().formatted()
        }
    }
}

struct Slider_Previews: PreviewProvider {
    @State static private var rgb = RGBValues(0, 0, 0)
    
    static var previews: some View {
        RGBSlider.SliderComponent(value: .r, rgb: $rgb, paletteItem: .constant(.init()))
            .frame(maxWidth: 250)
    }
}
