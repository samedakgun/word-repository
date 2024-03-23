import SwiftUI

@main
struct DilPratikApp: App {
    var viewModel = KelimeViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
        }
    }
}
