//
//  ContentView.swift
//  ceiba-users
//
//  Created by Daniel Orellana on 1/05/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject var viewModel: UserViewModel = UserViewModel()
    
    var body: some View {
        Text("test")
    }
}
