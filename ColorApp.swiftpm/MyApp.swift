import SwiftUI

@main
struct MyApp: App {
    @StateObject private var model = Model()
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(model)
                .onAppear {
                    setUpNavigationTitleFont()
                    #if targetEnvironment(simulator)
                    createTMPDirectory()
                    #endif
                }
            #if targetEnvironment(simulator)
                .onChange(of: scenePhase) { phase in
                    do {
                        if phase == .background, FileManager.default.fileExists(atPath: Model.tmpURL.path()) {
                            try FileManager.default.removeItem(at: Model.tmpURL)
                            model.save()
                        } else if phase == .active, !FileManager.default.fileExists(atPath: Model.tmpURL.path()) {
                            createTMPDirectory()
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            #endif
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
    
    func createTMPDirectory() {
        do {
            let tmp = Model.tmpURL
            
            if !FileManager.default.fileExists(atPath: tmp.path()) {
                try FileManager.default.createDirectory(at: tmp, withIntermediateDirectories: false)
            }
        } catch {
            print(error)
        }
    }
}
