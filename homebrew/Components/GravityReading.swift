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
            Image("testtube").resizable().frame(width: 25, height: 25).padding()
            Text("\(date, formatter: brewDateFormatter)")
            Spacer()
            Text("\(String(format: "%.3f", gravity)) (\(String(format: "%.2f", (originalGravity-gravity)*131.25))%)")
        }
    }
}
