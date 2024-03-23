import SwiftUI

struct KelimeEkleView: View {
    @ObservedObject var viewModel: KelimeViewModel
    @State private var ingilizce = ""
    @State private var turkce = ""

    var body: some View {
        NavigationView {
            VStack {
                TextField("İngilizce", text: $ingilizce)
                    .padding()
                TextField("Türkçe", text: $turkce)
                    .padding()
                Button("Ekle") {
                    viewModel.kelimeEkle(ingilizce: ingilizce, turkce: turkce)
                    ingilizce = ""
                    turkce = ""
                }
                .padding()
            }
            .navigationBarTitle("Kelime Ekle", displayMode: .inline)
        }
    }
}
