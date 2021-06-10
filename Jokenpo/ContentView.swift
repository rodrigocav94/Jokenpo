//
//  ContentView.swift
//  Jokenpo
//
//  Created by Rodrigo Cavalcanti on 23/10/20.
//

import SwiftUI

struct TituloEscolha: View {
    var texto: String
    var body: some View {
        Text(texto)
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(Color.white)
            .multilineTextAlignment(.center)
    }
}

struct BotãoEmoji: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .padding()
            .background(Color.white .opacity(0.4) .clipShape(Circle()) .shadow(color: .black, radius: 40))
    }
}

extension View {
    func botãoemoji() -> some View {
        self.modifier(BotãoEmoji())
    }
}

struct BotãoContinuar: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.yellow)
            .font(.title3)
            .padding()
            .background(Color.white .opacity(0.4) .clipShape(Capsule()) .shadow(color: .black, radius: 40))
    }
}

struct ContentView: View {
    var simbolos = ["👊", "🖐", "✌️"]
    @State private var mãojogador = 0
    @State private var mãocomputador = Int.random(in: 0...2)
    @State private var escolhido = false
    @State private var totalPartidas = 1
    @State private var vitorias = 0
    @State private var tituloResultado = ""
    
    struct BackgroundColorido: View {
        var blur: Bool
        var body: some View {
            AngularGradient(gradient: Gradient(colors: [.orange, .pink, .red, .purple, .blue]), center: .center)
                .frame(width: .infinity, height: .infinity)
                .edgesIgnoringSafeArea(.all)
                .blur(radius: blur ? 50:0)
        }
    }
    
    var body: some View {
        ZStack {
            BackgroundColorido(blur: false)
            BackgroundColorido(blur: true)
            VStack {
                Spacer()
                VStack {
                    TituloEscolha(texto: "Você Escolhe:")
                    HStack {
                        if escolhido {
                            Text(simbolos[mãojogador])
                                .botãoemoji()
                        } else {
                            ForEach(0 ..< simbolos.count) { numero in
                                Button("\(simbolos[numero])") {
                                    self.mãojogador = numero
                                    escolhido = true
                                    if self.mãocomputador == self.mãojogador - 1 || self.mãocomputador == self.mãojogador + 2 {
                                        self.tituloResultado = "Vitória!"
                                        vitorias += 1
                                    } else if self.mãocomputador == self.mãojogador {
                                        self.tituloResultado = "Empate!"
                                    } else {
                                        self.tituloResultado = "Derrota!"
                                    }
                                }
                                .botãoemoji()
                            }
                        }
                    }
                }
                Spacer()
                VStack {
                    TituloEscolha(texto: "O Computador \n Escolhe:")
                    if escolhido {
                        Text(simbolos[mãocomputador])
                            .botãoemoji()
                    } else {
                        Text("?")
                            .fontWeight(.bold)
                            .foregroundColor(Color.yellow)
                            .botãoemoji()
                    }
                }
                Spacer()
                VStack {
                    if escolhido {
                        TituloEscolha(texto: tituloResultado)
                    }
                    Text("Você ganhou \(vitorias) de \(totalPartidas) partidas.")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                    if escolhido {
                        Button("Continuar") {
                            mãocomputador = Int.random(in: 0...2)
                            escolhido = false
                            if totalPartidas < 10 {
                                totalPartidas += 1
                            } else {
                                totalPartidas = 1
                                vitorias = 0
                            }
                        }
                        .modifier(BotãoContinuar())
                    }
                }
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
