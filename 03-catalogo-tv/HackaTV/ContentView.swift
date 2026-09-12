    import SwiftUI

    struct Conteudo: Identifiable, Hashable {
        let id = UUID()
        let titulo: String
        let ano: String
        let genero: String
        let imagemUrl: String
        let notaIMDb: String
        let bandeiraPais: String
        let tipo: TipoConteudo
    }

    enum TipoConteudo: String {
        case filme = "Filme"
        case serie = "Série"
    }

    struct DadosIniciais {
        static let filmes: [Conteudo] = [
            Conteudo(titulo: "O Gato de Botas", ano: "2011", genero: "Animação, Aventura", imagemUrl: "https://upload.wikimedia.org/wikipedia/pt/7/78/Puss_in_Boots_The_Last_Wish_poster.jpg", notaIMDb: "6,6", bandeiraPais: "🇺🇸", tipo: .filme),
            Conteudo(titulo: "Garfield: Fora de Casa", ano: "2024", genero: "Animação, Comédia", imagemUrl: "https://m.media-amazon.com/images/S/pv-target-images/d9f901ea28d87e1862c664d401fc02c2ff478a0fdfd537d8b178fea53ad220bc.jpg", notaIMDb: "6,4", bandeiraPais: "🇺🇸", tipo: .filme),
            Conteudo(titulo: "Aristogatas", ano: "1970", genero: "Animação, Família", imagemUrl: "https://br.web.img2.acsta.net/c_310_420/pictures/bzp/04/96.jpg", notaIMDb: "7,1", bandeiraPais: "🇺🇸", tipo: .filme),
            Conteudo(titulo: "O Gato de Botas 2: O Último Pedido", ano: "2022", genero: "Animação, Aventura", imagemUrl: "https://play-lh.googleusercontent.com/QrSBQU8p6TijnsH2EfDpBfneddIP6JVYR4bSKyacA-cyIiYZQqdiryOTMkwqxxnfvfaL9UOhIo8-3XI2MWvQ", notaIMDb: "7,9", bandeiraPais: "🇺🇸", tipo: .filme),
            Conteudo(titulo: "Garfield: O Filme", ano: "2004", genero: "Comédia, Família", imagemUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTfHV0no4TaX614LfZWUnMzOXOI6FHZRIzUPEFJGVZ8dMHsK2NKAb8n3-tG&s=10", notaIMDb: "5,1", bandeiraPais: "🇺🇸", tipo: .filme)
        ]
        
        static let series: [Conteudo] = [
            Conteudo(titulo: "As Aventuras do Gato de Botas", ano: "2015", genero: "Animação, Comédia", imagemUrl: "https://play-lh.googleusercontent.com/QrSBQU8p6TijnsH2EfDpBfneddIP6JVYR4bSKyacA-cyIiYZQqdiryOTMkwqxxnfvfaL9UOhIo8-3XI2MWvQ", notaIMDb: "6,6", bandeiraPais: "🇺🇸", tipo: .serie),
            Conteudo(titulo: "Garfield e Seus Amigos", ano: "1988", genero: "Animação, Comédia", imagemUrl: "https://tmdb.org", notaIMDb: "8,0", bandeiraPais: "🇺🇸", tipo: .serie),
            Conteudo(titulo: "O Show do Garfield", ano: "2008", genero: "Animação, Comédia", imagemUrl: "https://tmdb.org", notaIMDb: "5,7", bandeiraPais: "🇫🇷", tipo: .serie),
            Conteudo(titulo: "Don Gato e Sua Turma", ano: "1961", genero: "Animação, Comédia", imagemUrl: "https://tmdb.org", notaIMDb: "7,2", bandeiraPais: "🇺🇸", tipo: .serie),
            Conteudo(titulo: "Simon's Cat", ano: "2008", genero: "Animação, Comédia", imagemUrl: "https://tmdb.org", notaIMDb: "8,0", bandeiraPais: "🇬🇧", tipo: .serie)
        ]
        
        static let recomendados: [Conteudo] = [
            Conteudo(titulo: "O Rei Leão", ano: "1994", genero: "Animação, Drama", imagemUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTfHV0no4TaX614LfZWUnMzOXOI6FHZRIzUPEFJGVZ8dMHsK2NKAb8n3-tG&s=10", notaIMDb: "8,5", bandeiraPais: "🇺🇸", tipo: .filme),
            Conteudo(titulo: "Gatos", ano: "2019", genero: "Musical, Fantasia", imagemUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSy8xPh92kdefeDRR-emD9HDlVAR05i0oucU5TYjTDr7cAT2V3TKPE49egS&s=10", notaIMDb: "2,8", bandeiraPais: "🇬🇧", tipo: .filme),
            Conteudo(titulo: "O Gato que Caiu do Céu", ano: "2023", genero: "Animação, Fantasia", imagemUrl: "https://play-lh.googleusercontent.com/QrSBQU8p6TijnsH2EfDpBfneddIP6JVYR4bSKyacA-cyIiYZQqdiryOTMkwqxxnfvfaL9UOhIo8-3XI2MWvQ", notaIMDb: "7,0", bandeiraPais: "🇨🇳", tipo: .filme),
            Conteudo(titulo: "Um Gato em Paris", ano: "2010", genero: "Animação, Crime", imagemUrl: "https://ingresso-a.akamaihd.net/prd/img/movie/gatos-no-museu/350237c1-4ff9-4702-86a1-347682046368.webp", notaIMDb: "6,9", bandeiraPais: "🇫🇷", tipo: .filme)
        ]
    }

    struct ConteudoRow: View {
        let item: Conteudo
        
        var body: some View {
            HStack(spacing: 14) {
                AsyncImage(url: URL(string: item.imagemUrl)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 40, height: 55)
                            .background(Color(.systemGray5))
                            .cornerRadius(4)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 55)
                            .clipped()
                            .cornerRadius(4)
                    case .failure:
                        Image(systemName: "film")
                            .foregroundColor(.gray)
                            .frame(width: 40, height: 55)
                            .background(Color(.systemGray6))
                            .cornerRadius(4)
                    @unknown default:
                        EmptyView()
                    }
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.titulo)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.primary)
                    Text(item.ano)
                        .font(.system(size: 12))
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Text(item.bandeiraPais)
                    .font(.system(size: 18))
            }
            .padding(.vertical, 8)
            .padding(.horizontal)
            .background(Color(.systemBackground))
        }
    }

    struct RecomendadoCard: View {
        let item: Conteudo
        
        var body: some View {
            VStack {
                AsyncImage(url: URL(string: item.imagemUrl)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Color.gray.opacity(0.2)
                }
                .frame(width: 90, height: 130)
                .cornerRadius(6)
                .clipped()
            }
        }
    }

    struct LogoHeaderView: View {
        var body: some View {
            HStack {
                Spacer()
                VStack(spacing: -4) {
                    Text("TV")
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                        .foregroundColor(.red)
                    Text("HACKA")
                        .font(.system(size: 26, weight: .black, design: .rounded))
                        .foregroundColor(.blue)
                        .italic()
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 6)
                .background(Color.gray.opacity(0.3))
                .cornerRadius(12)
                Spacer()
            }
            .padding(.vertical)
        }
    }

    struct DetalheView: View {
        let conteudo: Conteudo
        var aoFechar: () -> Void
        
        var body: some View {
            
            ZStack {
                Color(.systemBackground).edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    HStack {
                        Button(action: aoFechar) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.gray)
                                .padding(10)
                                .background(Color(.systemGray6))
                                .clipShape(Circle())
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    AsyncImage(url: URL(string: conteudo.imagemUrl)) { image in image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 220, height: 320)
                    .cornerRadius(16)
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                    
                    Text(conteudo.titulo)
                        .font(.system(size: 28, weight: .bold))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    VStack(spacing: 8) {
                        HStack {
                            Text("Categoria:").bold()
                            Text(conteudo.tipo.rawValue)
                        }
                        HStack {
                            Text("Ano:").bold()
                            Text(conteudo.ano)
                        }
                        HStack {
                            Text("Gênero:").bold()
                            Text(conteudo.genero)
                        }
                        HStack {
                            Text("País:").bold()
                            Text(conteudo.bandeiraPais)
                        }
                    }
                    .font(.system(size: 16))
                    .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    VStack {
                        Text("IMDb: \(conteudo.notaIMDb)")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .foregroundColor(.primary)
                            .padding(.horizontal, 30)
                            .padding(.vertical, 12)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.blue, lineWidth: 2)
                            )
                    }
                    .padding(.bottom, 30)
                }
            }
        }
    }

    struct ContentView: View {
        @State private var itemSelecionado: Conteudo? = nil
        
        var body: some View {
            ZStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 22) {
                        
                        LogoHeaderView()
                        
                        VStack(alignment: .leading, spacing: 0) {
                            Text("FILMES")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.orange)
                                .padding(.horizontal)
                                .padding(.bottom, 6)
                            
                            ForEach(DadosIniciais.filmes) { filme in
                                Button(action: { itemSelecionado = filme }) {
                                    ConteudoRow(item: filme)
                                }
                                .buttonStyle(PlainButtonStyle())
                                Divider().padding(.leading)
                            }
                        }
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Recomendados")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.orange)
                                .padding(.horizontal)
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 14) {
                                    ForEach(DadosIniciais.recomendados) { recomendado in Button(action: { itemSelecionado = recomendado })
                                        {RecomendadoCard(item: recomendado)
                                        }
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                        VStack(alignment: .leading, spacing: 0) {Text("SÉRIES").font(.system(size: 14, weight: .bold))
                                .foregroundColor(.orange).padding(.horizontal).padding(.bottom, 6)
                            ForEach(DadosIniciais.series) {
                                serie in Button(action: { itemSelecionado = serie }) {ConteudoRow(item:serie)}
                                    .buttonStyle(PlainButtonStyle())
                                    Divider().padding(.leading)
                            }
                        }
                    }
                }
                if let conteudoAtivo = itemSelecionado {DetalheView(conteudo: conteudoAtivo) {withAnimation(.spring()) {itemSelecionado = nil}}.transition(.move(edge: .trailing)).zIndex(1)
                }
            }
            .animation(.easeInOut, value: itemSelecionado)
        }
    }

    struct ContentView_Previews: PreviewProvider {static var previews: some
        
        View {
            ContentView()
    }
    }
