import SwiftUI
import FirebaseAI

struct AlienResponse: Codable {
    let nome: String
    let status: String
    let imageUrl: String
}

struct ContentView: View {
    let model = FirebaseAI.firebaseAI(backend: .googleAI()).generativeModel(
        modelName: "gemini-3.1-flash-lite",
        generationConfig: GenerationConfig(
            responseMIMEType: "application/json"
        ),
        systemInstruction: ModelContent(
            role: "system",
            parts: "Você é um especialista em Ben 10. O usuário enviará o nome de um alien. Você DEVE responder estritamente com um objeto JSON contendo as chaves: 'nome' (nome correto do alien), 'status' (uma breve descrição dos poderes dele) e 'imageUrl' (uma URL direta e válida da imagem oficial desse alien na Wiki de Ben 10 ou similar). Não adicione markdown ou textos extras fora do JSON."
        )
    )
    
    @State var prompt: String = ""
    @State var alienName: String = ""
    @State var alienStatus: String = ""
    @State var alienImageUrl: String = ""
    @State var isLoading: Bool = false
    @State var errorMessage: String = ""
    
    func sendMessage() {
        let userPrompt = prompt
        prompt = ""
        isLoading = true
        errorMessage = ""
        
        Task {
            do {
                let response = try await model.generateContent(userPrompt)
                guard let jsonText = response.text?.data(using: .utf8) else {
                    throw NSError(domain: "Resposta vazia", code: 0)
                }
                
                let decodedResponse = try JSONDecoder().decode(AlienResponse.self, from: jsonText)
                
                await MainActor.run {
                    self.alienName = decodedResponse.nome
                    self.alienStatus = decodedResponse.status
                    self.alienImageUrl = decodedResponse.imageUrl
                }
            } catch {
                await MainActor.run {
                    self.errorMessage = "Erro ao carregar alien: \(error.localizedDescription)"
                }
            }
            await MainActor.run {
                isLoading = false
            }
        }
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Buscador de Aliens - Ben 10")
                .font(.title2)
                .bold()
            
            HStack {
                TextField("Digite o nome ou características de um alien...", text: $prompt)
                    .textFieldStyle(.roundedBorder)
                    .onSubmit { sendMessage() }
                
                if isLoading {
                    ProgressView()
                        .padding(.horizontal, 5)
                } else {
                    Button(action: sendMessage) {
                        Image(systemName: "paperplane.fill")
                    }
                    .disabled(prompt.isEmpty)
                }
            }
            .padding(.horizontal)
            
            ScrollView {
                VStack(spacing: 15) {
                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .foregroundStyle(.red) 
                    }
                    
                    if !alienImageUrl.isEmpty, let url = URL(string: alienImageUrl) {
                        AsyncImage(url: url) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .frame(height: 200)
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxHeight: 250)
                                    .cornerRadius(12)
                                    .shadow(radius: 5)
                            case .failure:
                                VStack(spacing: 8) {
                                    Image(systemName: "photo")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 60)
                                        .foregroundColor(.gray)
                                    Text("Não foi possível renderizar a URL gerada.")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                .frame(height: 200)
                            @unknown default:
                                EmptyView()
                            }
                        }
                    }
                    
                    if !alienName.isEmpty {
                        Text(alienName)
                            .font(.title3)
                            .bold()
                        
                        Text(alienStatus)
                            .font(.body)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                }
            }
        }
        .padding(.vertical)
    }
}

