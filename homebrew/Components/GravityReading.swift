//
//  GravityReading.swift
//  homebrew
//
//  Created by Lucas Desouza on 1/26/21.
//

import SwiftUI

struct GravityReading: View
{

    var date: Date
    var gravity: Double
    var originalGravity: Double

    var body: some View {
        HStack {
            Image("testtube").resizable().frame(width: 15, height: 10).padding()
            Text("\(date, formatter: brewDateFormatter)")
            Spacer()
            Text("\(gravity) (\((originalGravity-gravity)*131.25)%)")
        }
    }
}

private let brewDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .short
    return formatter
}()
