import SwiftUI

struct EgzersizView: View {
    @ObservedObject var viewModel: KelimeViewModel
    @State private var cevap = ""
    @State private var sorulanKelime: Kelime?
    @State private var mesaj = ""
    @State private var dilModu = Bool.random()
    
    var body: some View {
        VStack {
            if let kelime = sorulanKelime {
                Text("Anlamı nedir: \(dilModu ? kelime.ingilizce : kelime.turkce)?")
                    .font(.title2)
                
                TextField("Cevabınız", text: $cevap)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button("Doğrula") {
                    let dogruCevap = dilModu ? kelime.turkce : kelime.ingilizce
                    if cevap.lowercased() == dogruCevap.lowercased() {
                        mesaj = "Doğru!"
                    } else {
                        mesaj = "Yanlış. Doğru cevap: \(dogruCevap)"
                    }
                    cevap = ""
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        mesaj = ""
                        rastgeleKelimeSec()
                    }
                }
                .padding()
                
                Button("Diğer Kelimeye Geç") {
                    cevap = ""
                    mesaj = ""
                    rastgeleKelimeSec()
                }
                .padding()
                
                Button("Ezberlendi") {
                    if let kelime = sorulanKelime {
                        viewModel.kelimeEzberlendi(kelime: kelime)
                        cevap = ""
                        mesaj = ""
                        rastgeleKelimeSec()
                    }
                }
                .padding()
                .padding()
                
                if !mesaj.isEmpty {
                    Text(mesaj)
                        .padding()
                }
            } else {
                Text("Kelime listesi boş.")
            }
        }
        .onAppear {
            rastgeleKelimeSec()
        }
    }
    
    func rastgeleKelimeSec() {
        sorulanKelime = viewModel.kelimeler.randomElement()
        dilModu = Bool.random()
    }
}
