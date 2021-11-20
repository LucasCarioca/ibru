//
//  NewBrewModifier.swift
//  iBru
//
//  Created by Lucas Desouza on 9/10/21.
//

import SwiftUI

struct NewBrewButtonModifier: ViewModifier {
    var onDisappear: () -> Void = {
    }

    func body(content: Content) -> some View {
        ZStack {
            content
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    NavigationLink(destination: NewBrewForm().onDisappear(perform: self.onDisappear)) {
                        Image("carboy").colorInvert()
                                .font(.system(.largeTitle))
                                .frame(width: 67, height: 67)
                                .background(Color.accentColor)
                                .cornerRadius(38.5)
                                .shadow(color: Color.black.opacity(0.3),
                                        radius: 3,
                                        x: 3,
                                        y: 3)
                    }
                }
            }
        }
    }
}
