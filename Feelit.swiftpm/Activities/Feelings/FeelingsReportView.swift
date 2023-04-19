import SwiftUI

struct FeelingsReportView: View {
    let report: FeelingsReport?
    
    var body: some View {
        GroupBox {
            if let report {
                VStack {
                    FeelingsPieChart(report: report)
                        .frame(maxWidth: 400)
                        .compositingGroup()
                        .frame(maxWidth: .infinity)
                        .padding()
                    
                    LazyVGrid(columns: [.init(.adaptive(minimum: 150), alignment: .leading)], alignment: .leading) {
                        ForEach(report.chartData.sorted { $0.percent < $1.percent}, id: \.feeling) { data in
                            HStack {
                                Text(data.feeling.emoji)
                                    .padding(4.5)
                                    .background {
                                        Circle()
                                            .fill(.linearGradient(colors: data.colors, startPoint: .topLeading, endPoint: .bottomTrailing))
                                        
                                        Circle()
                                            .stroke(.regularMaterial.shadow(.inner(color: .primary.opacity(0.6), radius: 0.3)), lineWidth: 4)
                                    }
                                    .accessibilityHidden(true)
                                
                                Text("\(data.feeling.text) \(report.formattedPercent(for: data.feeling))")
                                    .font(.callout)
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.1)
                            }
                        }
                    }
                    .padding(5)
                }
                .frame(maxWidth: 400)
            } else {
                Text("There's not enough data to generate the report for your palette.\nPlease choose feelings for the colors you created.")
                    .font(.title3)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(50)
            }
        } label: {
            Text("Feelings Report")
                .fontWidth(.expanded)
        }
        .groupBoxStyle(.material(.thinMaterial))
        .padding()
    }
}

struct FeelingsReportView_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            FeelingsReportView(report: .init(palette: .example))
        }
    }
}
