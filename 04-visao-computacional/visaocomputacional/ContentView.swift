//
//  ContentView.swift
//  visaocomputacional
//
//  Created by Turma02-22 on 27/07/26.
//
import Vision
import SwiftUI
import PhotosUI
import AVFoundation // Importado conforme a nova imagem

struct ContentView: View {
    @State private var photoPicked: PhotosPickerItem?
    @State private var imageToAnalise: UIImage?
    @State private var detectedText: String = ""
    
    // Instanciado o sintetizador de voz fora do body
    let sintetizador = AVSpeechSynthesizer()

    var body: some View {
        VStack(spacing: 20) {
            // Exibe a imagem na tela se ela já tiver sido carregada
            if let image = imageToAnalise {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 300)
                    .cornerRadius(12)
            } else {
                ContentUnavailableView("Nenhuma Imagem",
                                       systemImage: "photo.on.rectangle",
                                       description: Text("Selecione uma foto da galeria para analisar."))
                    .frame(maxHeight: 300)
            }

            // Exibe o resultado da leitura do código de barras
            if !detectedText.isEmpty {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Código Detectado:")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(detectedText)
                        .font(.body)
                        .bold()
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(10)
                    
                    // Botão adaptado da imagem para narrar o texto obtido
                    Button(action: {
                        let enunciado = AVSpeechUtterance(string: detectedText)
                        enunciado.voice = AVSpeechSynthesisVoice(language: "pt-BR")
                        enunciado.rate = 0.3
                        sintetizador.speak(enunciado)
                    }) {
                        Label("Escutar Texto", systemImage: "speaker.wave.2.fill")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.indigo)
                            .foregroundStyle(.white)
                            .cornerRadius(25)
                    }
                    .padding(.top, 10)
                }
                .padding(.horizontal)
            }

            PhotosPicker(selection: $photoPicked,
                         matching: .images,
                         photoLibrary: .shared()) {
                Text("Pegar da Galeria")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.indigo)
                    .foregroundStyle(.white)
                    .cornerRadius(25)
                    .padding(.horizontal)
            }
            .onChange(of: photoPicked) { oldValue, newValue in
                if let newValue = newValue {
                    Task {
                        if let data = try? await newValue.loadTransferable(type: Data.self),
                           let image = UIImage(data: data) {
                            imageToAnalise = image
                            
                            // Executa a função de detecção assim que a imagem é carregada
                            await detectBarCode(photo: image)
                        }
                    }
                }
            }
        }
        .padding()
    }

    @MainActor
    func detectBarCode(photo: UIImage?) async {
        let request = DetectBarcodesRequest()
        guard let image = photo else { return }
        guard let cgImage = image.cgImage else { return }
        let result = try? await request.perform(on: cgImage)
        
        let item = result?.first?.payloadString
        detectedText = item ?? "Nenhum código encontrado"
    }
}

#Preview {
    ContentView()
}

