//
//  categories.swift
//  iBru
//
//  Created by Lucas Desouza on 1/10/22.
//

import Foundation

enum BrewCategory: String {
    case ALL = "all"
    case BEER = "Beer"
    case WINE = "Wine"
    case MEAD = "Mead"
    case CIDER = "Cider"
    case OTHER = "Other"
    
    static let allValues = [BEER, WINE, MEAD, CIDER, OTHER]
}
