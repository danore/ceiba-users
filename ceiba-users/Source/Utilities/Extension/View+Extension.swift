//
//  View+Extension.swift
//  ceiba-users
//
//  Created by Daniel Orellana on 1/05/22.
//

import SwiftUI

extension View {
    func greenNavigationBar() -> some View {
        modifier(NavigationBarViewModifier())
    }
}

struct NavigationBarViewModifier: ViewModifier {

    func body(content: Content) -> some View {
        content
            .onAppear {
                NavigationBarTheme.blueNavigationBar()
            }
    }
}

class NavigationBarTheme {

    static func blueNavigationBar() {
        UINavigationBar.appearance().tintColor = UIColor.white

        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(Color.appGreen)
        appearance.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 16, weight: .bold),
            .foregroundColor: UIColor(Color.white),
            .textEffect: NSAttributedString.TextEffectStyle.letterpressStyle
        ]

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
    }
}
