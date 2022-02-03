//
// Created by Lucas Desouza on 1/25/22.
//

import Foundation
import SwiftUI

struct CollectionRoot: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: HomebrewCollectionList()) {
                    Text("Homebrew")
                }
                NavigationLink(destination: PurchasedCollectionList()) {
                    Text("Purchased")
                }
            }
                    .navigationTitle("Collection")
        }

    }
}
