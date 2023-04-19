import SwiftUI

struct PaletteReportView: View {
    let palette: Palette
    
    var feelingsReport: FeelingsReport? {
        FeelingsReport(palette: palette)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    FeelingsReportView(report: feelingsReport)
                }
            }
            .navigationTitle("Report")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { DismissButton() }
        }
    }
}

struct PaletteReportView_Previews: PreviewProvider {
    static var previews: some View {
        PaletteReportView(palette: .example)
    }
}
