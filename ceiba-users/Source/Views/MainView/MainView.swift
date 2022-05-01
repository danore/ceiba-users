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
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.users, id: \.id) { user in
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
                                Spacer()
                                Button {
                                    print("Test")
                                } label: {
                                    Text("VER PUBLICACIONES")
                                        .foregroundColor(Color.appGreen)
                                        .font(.system(size: 14, weight: .bold))
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
            .greenNavigationBar()
            .navigationBarTitle("Prueba de ingreso")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
