import SwiftUI

struct RGBSlider: View {
    @Binding var paletteItem: PaletteItem
    
    @State private var rgb: RGBValues
    @FocusState private var focused: RGB?
    
    init(paletteItem: Binding<PaletteItem>) {
        _paletteItem = paletteItem
        _rgb = State(wrappedValue: paletteItem.wrappedValue.color.rgbValues)
    }
    
    var body: some View {
        Grid {
            GridRow {
                SliderComponent(value: .r, rgb: $rgb, paletteItem: $paletteItem)
                
                Spacer(minLength: 16)
                
                TextField("Red", value: $rgb.red, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: 60)
                    .focused($focused, equals: .r)
                    .accessibilityLabel("Red Field")
            }
            
            GridRow {
                SliderComponent(value: .g, rgb: $rgb, paletteItem: $paletteItem)
                
                Spacer(minLength: 16)
                
                TextField("Green", value: $rgb.green, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: 60)
                    .focused($focused, equals: .g)
                    .accessibilityLabel("Green Field")
            }
            
            GridRow {
                SliderComponent(value: .b, rgb: $rgb, paletteItem: $paletteItem)
                
                Spacer(minLength: 16)
                
                TextField("Blue", value: $rgb.blue, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: 60)
                    .focused($focused, equals: .b)
                    .accessibilityLabel("Blue Field")
            }
        }
        .onChange(of: rgb) { newRGB in
            rgb.red = min(newRGB.red, 255)
            rgb.green = min(newRGB.green, 255)
            rgb.blue = min(newRGB.blue, 255)
            update()
        }
        .onChange(of: paletteItem) { item in
            withAnimation {
                rgb = item.color.rgbValues
            }
        }
        .toolbar {
            if focused != nil {
                ToolbarItem(placement: .keyboard) {
                    HStack {
                        Button(action: previousField) {
                            Label("Previous Field", systemImage: "chevron.up")
                        }
                        .disabled(focused == .r)
                        
                        Button(action: nextField) {
                            Label("Next Field", systemImage: "chevron.down")
                        }
                        .disabled(focused == .b)
                        
                        Spacer()
                        Button("Done") { focused = nil }
                    }
                }
            }
        }
    }
    
    func update() {
        guard let (_, _, _, alpha) = paletteItem.color.rgbaComponents else { return }
        let rgbDouble = rgb.doubleValues
        
        withAnimation {
            paletteItem.color = Color(red: rgbDouble.red, green: rgbDouble.green, blue: rgbDouble.blue, opacity: alpha)
        }
    }
    
    func previousField() {
        guard let focused else { return }
        
        switch focused {
        case .r: return
        case .g: self.focused = .r
        case .b: self.focused = .g
        }
    }
    
    func nextField() {
        guard let focused else { return }
        
        switch focused {
        case .r: self.focused = .g
        case .g: self.focused = .b
        case .b: return
        }
    }
    
    
}

struct RGBSlider_Previews: PreviewProvider {
    static var previews: some View {
        RGBSlider(paletteItem: .constant(PaletteItem(color: Color(red: 0.45, green: 0.33, blue: 0.9))))
    }
}
