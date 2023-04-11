import SwiftUI

@main
struct MyApp: App {
    @StateObject private var model = Model()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(model)
                .onAppear(perform: setUpNavigationTitleFont)
        }
    }
    
    func setUpNavigationTitleFont() {
        let appearence = UINavigationBar.appearance()
        
        let largeNavTitleFont = UIFont.systemFont(ofSize: 34, weight: .bold, width: .expanded)
        let largeTitleFontMetrics = UIFontMetrics(forTextStyle: .largeTitle)
        
        let navTitleFont = UIFont.systemFont(ofSize: 17, weight: .semibold, width: .expanded)
        let headlineFontMetrics = UIFontMetrics(forTextStyle: .body)
        
        appearence.largeTitleTextAttributes = [.font: largeTitleFontMetrics.scaledFont(for: largeNavTitleFont)]
        appearence.titleTextAttributes = [.font: headlineFontMetrics.scaledFont(for: navTitleFont)]
    }
}
