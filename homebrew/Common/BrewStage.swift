//
//  BrewStag.swift
//  iBru
//
//  Created by Lucas Desouza on 9/10/21.
//

import Foundation

enum BrewStage: String {
    case primary = "Primary Fermentation"
    case secondary = "Secondary Fermentation"
    case bottled = "Bottled"
}

func getStage(of brew: Brew) -> BrewStage {
    if brew.bottles != nil {
        return .bottled
    } else if brew.secondary != nil {
        return .secondary
    }
    return .primary
}
