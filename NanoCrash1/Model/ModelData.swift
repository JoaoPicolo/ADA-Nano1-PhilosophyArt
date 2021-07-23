//
//  ModelData.swift
//  NanoCrash1
//
//  Created by João Pedro Picolo on 21/07/21.
//

import Foundation
import Combine
import UIKit


final class ModelData: ObservableObject {
    @Published var scenes: [Scene] = load("sceneData.json")
    @Published var descriptions: [String] = [
        "Infelizmente você não conseguiu nenhuma faixa...",
        "Parabéns! A faixa branca representa a busca pela melhora e pela verdade.",
        "Parabéns! A faixa amarela representa o aflorecimento dos conhecimentos e nobreza.",
        "Parabéns! A faixa laranja representa a coragem e gentileza.",
        "Parabéns! A faixa verde representa harmonia e esperança.",
        "Parabéns! A faixa roxa representa a dignidade e purificação.",
        "Parabéns! A faixa marrom representa equilíbrio e sensatez.",
        "Parabéns! A faixa preta representa a humildade e maturidade.",
    ]
    @Published var kimonos: [String] = [
        "shoked.png", "KimonoWhite.png", "KimonoYellow.png", "KimonoOrange.png",
        "KimonoGreen.png", "KimonoPurple.png", "KimonoBrown.png", "KimonoBlack.png",
    ]
}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
