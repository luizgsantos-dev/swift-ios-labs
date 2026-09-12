//
//  HackaTVApp.swift
//  HackaTV
//
//  Created by Turma02-22 on 13/07/26.
//

import SwiftUI
struct Filmes: Hashable{
    let nome: String
    let categorias: String
    let ano: String
    let genero: String
    let pais: String
    let imdb: Double
}

@main
struct HackaTVApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
