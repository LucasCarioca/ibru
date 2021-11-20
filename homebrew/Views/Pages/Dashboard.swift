//
//  Dashboard.swift
//  iBru
//
//  Created by Lucas Desouza on 9/9/21.
//

import SwiftUI
import QuickComponents

struct Dashboard: View {
    var body: some View {
        VStack {
            SwitcherView(pages: [
                SwitcherPage(label: "Primary", view: PrimaryList()),
                SwitcherPage(label: "Secondary", view: SecondaryList()),
                SwitcherPage(label: "Bottled", view: BottledList())
            ]).padding()
            Spacer()
        }
                .navigationTitle("Dashboard")
    }
}

struct Dashboard_Previews: PreviewProvider {
    static var previews: some View {
        Dashboard()
    }
}
