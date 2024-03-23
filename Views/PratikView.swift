import SwiftUI

struct PratikView: View {
    @ObservedObject var viewModel: KelimeViewModel

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Kelime Sayısı: \(viewModel.kelimeler.count)")) {
                    ForEach(viewModel.kelimeler) { kelime in
                        VStack(alignment: .leading) {
                            Text(kelime.ingilizce)
                                .font(.headline)
                            Text(kelime.turkce)
                                .font(.subheadline)
                        }
                    }
                    .onDelete(perform: viewModel.kelimeSil) // Silme işlevi
                }
            }
            .navigationBarTitle("Pratik Yap", displayMode: .inline)
            .navigationBarItems(trailing: EditButton())
        }
    }
}
