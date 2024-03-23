import Foundation
import SwiftUI

class KelimeViewModel: ObservableObject {
    @Published var kelimeler: [Kelime] = []
    @Published var ezberlenenKelimeler: [Kelime] = []

    init() {
        loadKelimeler()
        loadEzberlenenKelimeler()
    }
    func kelimeyiAnaListeyeGeriYukle(kelime: Kelime) {
        // Kelimeyi ana listeye geri yükleme işlemi
        kelimeler.append(kelime)
        saveKelimeler()
    }

    func kelimeEkle(ingilizce: String, turkce: String) {
        let yeniKelime = Kelime(ingilizce: ingilizce, turkce: turkce)
        kelimeler.append(yeniKelime)
        saveKelimeler()
    }
    
    func kelimeSil(indexSet: IndexSet) {
        kelimeler.remove(atOffsets: indexSet)
        saveKelimeler()
    }

    func kelimeEzberlendi(kelime: Kelime) {
        if let index = kelimeler.firstIndex(where: { $0.id == kelime.id }) {
            kelimeler.remove(at: index)
            ezberlenenKelimeler.append(kelime)
            saveKelimeler()
            // saveEzberlenenKelimeler() metodunuz varsa burada çağırabilirsiniz
        }
    }

    private func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
     func saveKelimeler() {
        do {
            let filePath = getDocumentsDirectory().appendingPathComponent("kelimeler.json")
            let data = try JSONEncoder().encode(kelimeler)
            try data.write(to: filePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Kelimeler kaydedilemedi: \(error.localizedDescription)")
        }
    }
    
    
    func kelimeyiGeriYukle(index: Int) {
        let kelime = ezberlenenKelimeler.remove(at: index)
        kelimeler.append(kelime)
        saveKelimeler() // Kelime listesini güncelle
        saveEzberlenenKelimeler() // Ezberlenen kelime listesini güncelle
    }

    
    func saveEzberlenenKelimeler() {
        do {
            let filePath = getDocumentsDirectory().appendingPathComponent("ezberlenenKelimeler.json")
            let data = try JSONEncoder().encode(ezberlenenKelimeler)
            try data.write(to: filePath, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Ezberlenen kelimeler kaydedilemedi: \(error)")
        }
    }

    private func loadKelimeler() {
        let filePath = getDocumentsDirectory().appendingPathComponent("kelimeler.json")
        do {
            let data = try Data(contentsOf: filePath)
            kelimeler = try JSONDecoder().decode([Kelime].self, from: data)
        } catch {
            kelimeler = []
        }
    }

    func loadEzberlenenKelimeler() {
        let filePath = getDocumentsDirectory().appendingPathComponent("ezberlenenKelimeler.json")
        do {
            let data = try Data(contentsOf: filePath)
            ezberlenenKelimeler = try JSONDecoder().decode([Kelime].self, from: data)
        } catch {
            ezberlenenKelimeler = []
        }
    }
  
}
