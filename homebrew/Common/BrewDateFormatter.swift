//
//  BrewDateFormatter.swift
//  iBru
//
//  Created by Lucas Desouza on 9/10/21.
//

import Foundation

let brewDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .none
    return formatter
}()
