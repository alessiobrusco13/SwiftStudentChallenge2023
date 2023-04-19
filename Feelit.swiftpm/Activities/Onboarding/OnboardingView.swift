import SwiftUI

struct OnboardingView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    @State private var selection = 0
    @AccessibilityFocusState private var focused: Int?
    @State private var samplePaletteItem = PaletteItem(color: .blue)
    
    var title: some View {
        (
            Text("Welcome to ")
            +
            Text("Feel It")
                .foregroundColor(.accentColor)
                .fontWeight(.heavy)
        )
        .font(.largeTitle.weight(.semibold).width(.expanded))
    }
    
    var samplePalettes: [Palette] {
        [
            Palette(name: "T-Shirt", items: [Color.red, Color.pink, Color.purple].map { PaletteItem(color: $0) }),
            Palette(name: "Book App", items: [Color.indigo, Color.purple, Color.yellow, Color.primary].map { PaletteItem(color: $0) }),
            Palette(name: "Portrait", items: [Color.brown, Color.mint, Color.blue, Color.orange, Color.green].map { PaletteItem(color: $0) })
            
        ]
    }
    
    var feelingPalette: Palette {
        Palette(name: "Test", items: [PaletteItem(color: .indigo, feeling: .health), PaletteItem(color: .mint, feeling: .ecoFriendliness), PaletteItem(color: .green, feeling: .ecoFriendliness), PaletteItem(color: .red, feeling: .love)])
    }
    
    var body: some View {
        GeometryReader { proxy in
            let frame = proxy.frame(in: .global)
            
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
                                Text("A new way to \(Text("feel").fontWidth(.expanded).fontWeight(.bold)) color")
                                    .font(.title2.weight(.medium))
                                    .foregroundColor(.secondary)
                                    .padding(.top, 80)
                                    .accessibilityLabel("Welcome to Feel It: a new way to feel color.")
                                    .accessibilityFocused($focused, equals: 0)
                                    .tag(0)
                                
                                VStack {
                                    featureLabel("Create original palettes for your every need", systemImage: "paintpalette")
                                    
                                    Spacer()
                                    
                                    VStack(spacing: 50) {
                                        ForEach(samplePalettes) { palette in
                                            PaletteGridItem(palette: .constant(palette))
                                                .frame(width: 300, height: 80)
                                        }
                                    }
                                    .accessibilityHidden(true)
                                    
                                    Spacer()
                                }
                                .accessibilityFocused($focused, equals: 1)
                                .tag(1)
                                
                                VStack {
                                    featureLabel("Unleash your creativity with RGB values", systemImage: "slider.horizontal.3")
                                    
                                    Spacer()
                                    
                                    VStack(spacing: 15) {
                                        ColorGridItem(paletteItem: $samplePaletteItem)
                                        
                                        RGBSlider(paletteItem: $samplePaletteItem, textFieldsHidden: true)
                                            .disabled(true)
                                            .onAppear {
                                                Task { @MainActor in
                                                    try? await Task.sleep(nanoseconds: 500_000_000)
                                                    samplePaletteItem.color = Color(rgb: RGBValues(230, 128, 168))
                                                }
                                            }
                                    }
                                    .padding(.horizontal, 20)
                                    .accessibilityHidden(true)
                                    
                                    Spacer()
                                }
                                .accessibilityFocused($focused, equals: 2)
                                .tag(2)
                                
                                VStack {
                                    featureLabel("Think about what feelings you convey through color", systemImage: "face.smiling")
                                    
                                    Spacer()
                                    
                                    FlowLayout {
                                        ForEach(Feeling.allCases, id: \.self) { feeling in
                                            Text(feeling.label)
                                                .font(.subheadline)
                                                .foregroundColor(.white)
                                                .padding(5)
                                                .background(Color.accentColor, in: RoundedRectangle(cornerRadius: 8))
                                        }
                                        
                                    }
                                    .padding(.horizontal, 20)
                                    .padding(.top, 20)
                                    .accessibilityHidden(true)
                                    
                                    Spacer()
                                }
                                .accessibilityFocused($focused, equals: 3)
                                .tag(3)
                                
                                VStack {
                                    featureLabel("Measure your coherence", systemImage: "chart.pie")
                                    
                                    Spacer()
                                    
                                    FeelingsPieChart(report: FeelingsReport(palette: feelingPalette)!)
                                        .padding(.horizontal, 20)
                                        .accessibilityHidden(true)
                                    
                                    Spacer()
                                }
                                .accessibilityFocused($focused, equals: 4)
                                .tag(4)
                                
                                VStack {
                                    featureLabel("Note", systemImage: "iphone")
                                    
                                    Text("To ensure you have the best experience possible, please run on a phisical device.\nThe app is fully compatible with iPhones, iPads and VoiceOver.")
                                        .font(.headline)
                                        .padding()
                                }
                                .accessibilityFocused($focused, equals: 5)
                                .tag(5)
                                
                                
                            }
                            .tabViewStyle(.page(indexDisplayMode: .never))
                            .padding(.top, 50)
                            .background(alignment: selection == 0 ? .center : .top) {
                                title
                                    .padding()
                                    .padding(.top, selection == 0 ? 0 : 15)
                                    .accessibilityHidden(true)
                            }
                        }
                    
                    Spacer()
                    
                    Button {
                        guard selection < 5 else {
                            dismiss()
                            return
                        }
                        
                        selection += 1
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
                .compositingGroup()
                .padding()
                
                if frame.width > frame.height && UIDevice.current.userInterfaceIdiom == .phone {
                    VStack(spacing: 10) {
                        Image(systemName: "rotate.left")
                            .font(.largeTitle)
                        
                        Text("The welome screen only supports portrait mode on iPhone.\nPlease rotate your device.")
                            .multilineTextAlignment(.center)
                    }
                    .foregroundStyle(.secondary)
                    .font(.headline)
                    .frame(width: 200, height: 200)
                    .padding()
                    .background(.regularMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .transition(.scale.combined(with: .opacity))
                }
            }
            .animation(.spring(), value: selection)
            .animation(.spring(), value: samplePaletteItem.color)
            .onChange(of: selection) { focused = $0 }
        }
    }
    
    func featureLabel(_ text: String, systemImage: String, font: Font = .title3) -> some View {
        HStack {
            Image(systemName: systemImage)
                .foregroundColor(.accentColor)
                .font(.largeTitle)
                .accessibilityHidden(true)
            
            Text(text)
                .font(font.weight(.semibold))
        }
        .padding(.horizontal, 5)
        .padding(.top, 65)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
