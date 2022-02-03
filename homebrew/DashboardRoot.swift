//
// Created by Lucas Desouza on 1/25/22.
//

import Foundation
import SwiftUI

struct DashboardRoot: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: PrimaryList()) {
                    Text("Primary Fermentation")
                }
                NavigationLink(destination: SecondaryList()) {
                    Text("Secondary Fermentation")
                }
                NavigationLink(destination: BottledList()) {
                    Text("Bottled")
                }
            }
                    .navigationTitle("Dashboard")
        }
    }
}
