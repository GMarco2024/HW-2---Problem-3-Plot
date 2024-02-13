import SwiftUI
import Observation

@main
struct HW_2_Problem3_Plot: App {
    
    @State var plotData = PlotClass()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(plotData)
        }
    }
}
