//
//  InfoLabel.swift
//  iBru
//
//  Created by Lucas Desouza on 9/10/21.
//

import SwiftUI

struct InfoLabel: View {
    var label: String
    var value: String
    var body: some View {
        HStack {
            Text("\(label): ")
                    .fontWeight(.bold)
            Text(value)
            Spacer()
        }
    }
}

