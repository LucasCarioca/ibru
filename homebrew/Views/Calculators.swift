//
//  Calculators.swift
//  homebrew
//
//  Created by Lucas Desouza on 2/5/21.
//

import SwiftUI

struct Calculators: View {
    var body: some View {
        List {
            NavigationLink(destination: ABVCalculator()) {
                Text("Alcohol by volume")
            }
        }
    }
}

struct Calculators_Previews: PreviewProvider {
    static var previews: some View {
        Calculators()
    }
}
