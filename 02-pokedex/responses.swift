import Foundation

struct PokeAPIResponse: Codable {
    let results: [PokemonResult]
}

struct PokemonResult: Codable, Identifiable {
    var id: String { url }
    let name: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case url
    }
    
    var pokemonID: Int {
        let components = url.components(separatedBy: "/")
        let filteredComponents = components.filter { !$0.isEmpty }
        
        if let lastComponent = filteredComponents.last, let id = Int(lastComponent) {
            return id
        }
        return 0
    }
}

