//
//  ProHidden.swift
//  iBru
//
//  Created by Lucas Desouza on 9/17/21.
//

import SwiftUI

struct ProHidden: ViewModifier {
    @EnvironmentObject var proStatusControl: ProStatusControl
    
    func body(content: Content) -> some View {
        if !proStatusControl.isPro {
            content
        } else {
            EmptyView()
        }
    }
}

