import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: KelimeViewModel

    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: KelimeEkleView(viewModel: viewModel)) {
                    Text("Kelime Ekle")
                }
                NavigationLink(destination: PratikView(viewModel: viewModel)) {
                    Text("kelime listem")
                }
                NavigationLink(destination: EgzersizView(viewModel: viewModel)) {
                    Text("Ezgersiz")
                }
                NavigationLink(destination: EzberlenenView(viewModel: viewModel)) {
                                   Text("Ezberlenen Kelimeler")
                               }
            }
            .navigationBarTitle("Dil Pratik")
        }
    }
}
