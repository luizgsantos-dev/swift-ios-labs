import SwiftUI

struct PokedexView: View {
    @State private var pokemonList: [PokemonResult] = []
    let service = PokemonService()
    let gridLayout = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: gridLayout, spacing: 16) {
                    
                    ForEach(pokemonList) { pokemon in
                        let pokemonURL = URL(string: "https://githubusercontent.com\(pokemon.pokemonID).png")

                        NavigationLink(destination: Text("Detalhes do \(pokemon.name.capitalized)")
                        ) {
                    
                            VStack(spacing: 8) {
                                HStack {
                                    Spacer()
                                    Text(String(format: "#%03d", pokemon.pokemonID))
                                        .font(.caption)
                                        .fontWeight(.bold)
                                        .foregroundColor(.secondary)
                                    
                                }
                                .padding(.horizontal, 8)
                                .padding(.top, 8)
                            
                                
                                
                                AsyncImage(url: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(pokemon.pokemonID).png")) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 100, height: 90)
                                    } placeholder: {
                                        ProgressView()
                                            .frame(width: 90, height: 90)
                                    }
                            }
                            .background(Color(.systemBackground))
                            .cornerRadius(20)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                        }
                    }
                }
                .padding()
            }
        
            .navigationTitle("Pokédex")
            .background(Color(.systemGroupedBackground))
            .task {
                do {
                    pokemonList = try await service.fetchPokemons()
                } catch {
                    print("Erro ao buscar Pokémons: \(error)")
                }
            }
        }
        
        
    }
}

#Preview {
    PokedexView()
}

