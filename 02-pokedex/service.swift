import Foundation

class PokemonService {
    func fetchPokemons() async throws -> [PokemonResult] {
        // Usamos componentes de URL para garantir que caracteres especiais não quebrem o endereço
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=151") else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // Validação estrita se o servidor retornou sucesso (Status 200)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        // Decodificação direta do JSON
        let decodedResponse = try JSONDecoder().decode(PokeAPIResponse.self, from: data)
        return decodedResponse.results
    }
}
