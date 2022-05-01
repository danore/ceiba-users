//
//  MainView.swift
//  ceiba-users
//
//  Created by Daniel Orellana on 1/05/22.
//

import SwiftUI
import CoreData

struct MainView: View {
    @StateObject var viewModel: UserViewModel = UserViewModel()
    @State var searchString: String = ""
    @State private var isDetailViewPresented: Bool = false
    @State private var currentUser: User?
    
    var body: some View {
        UserSearchController(
            text: $searchString,
            search: {},
            cancel: {
                searchString = ""
                viewModel.filter(onText: searchString)
            },
            textChanged: {
                viewModel.filter(onText: searchString)
            }) {
                VStack {
                    List {
                        ForEach(viewModel.finalUsers, id: \.id) { user in
                            VStack(alignment: .leading, spacing: 2) {
                                Text(user.name ?? "Unknown")
                                    .foregroundColor(Color.appGreen)
                                    .font(.system(size: 16, weight: .bold))
                                
                                HStack(spacing: 5) {
                                    Image(systemName: "phone.fill")
                                        .font(.system(size: 16))
                                        .foregroundColor(Color.appGreen)
                                    
                                    Text(user.phone ?? "Unknown")
                                        .font(.system(size: 14))
                                }
                                
                                HStack(spacing: 5) {
                                    Image(systemName: "envelope.fill")
                                        .font(.system(size: 16))
                                        .foregroundColor(Color.appGreen)
                                    
                                    Text(user.email ?? "Unknown")
                                        .font(.system(size: 14))
                                }
                                
                                HStack {
                                    ZStack(alignment: .trailing) {
                                        NavigationLink(
                                            destination: UserDetailView().environmentObject(user)) {
                                                EmptyView()
                                            }
                                            .opacity(0)
                                        
                                        Text("VER PUBLICACIONES")
                                            .foregroundColor(Color.appGreen)
                                    }
                                }
                                .padding(.top, 10)
                            }
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 120, alignment: .topLeading)
                            .padding(5)
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
        
    }
}
