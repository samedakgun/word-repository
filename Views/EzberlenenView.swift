import SwiftUI

struct EzberlenenView: View {
    @ObservedObject var viewModel: KelimeViewModel

    var body: some View {
        List {
            ForEach(viewModel.ezberlenenKelimeler) { kelime in
                HStack {
                    VStack(alignment: .leading) {
                        Text(kelime.ingilizce)
                            .font(.headline)
                        Text(kelime.turkce)
                            .font(.subheadline)
                    }
                    Spacer()
                    Button("Geri Yükle") {
                        // Bu butona tıklanıldığında kelimeyi tekrar kelime listesine geri yükle
                        guard let index = viewModel.ezberlenenKelimeler.firstIndex(where: { $0.id == kelime.id }) else { return }
                        viewModel.kelimeyiAnaListeyeGeriYukle(kelime: kelime)
                        viewModel.ezberlenenKelimeler.remove(at: index)
                        viewModel.saveKelimeler()
                        viewModel.saveEzberlenenKelimeler()
                    }
                }
            }
            .onDelete(perform: deleteEzberlenenKelime)
        }
        .navigationBarTitle("Ezberlenen Kelimeler", displayMode: .inline)
    }

    func deleteEzberlenenKelime(at offsets: IndexSet) {
        viewModel.ezberlenenKelimeler.remove(atOffsets: offsets)
        viewModel.saveEzberlenenKelimeler()
    }
}
