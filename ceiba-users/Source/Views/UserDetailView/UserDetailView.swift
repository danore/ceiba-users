//
//  UserDetailView.swift
//  ceiba-users
//
//  Created by Daniel Orellana on 1/05/22.
//

import SwiftUI

struct UserDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var currentUser: User
    @ObservedObject var postViewModel: PostViewModel = PostViewModel()
    
    var body: some View {
        VStack {
            VStack {
                Text(currentUser.phone ?? "Unknown")
                    .foregroundColor(.white)
                Text(currentUser.email ?? "Unknown")
                    .foregroundColor(.white)
            }
            .padding(25)
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            .background(Color.appGreen)
            
            List {
                ForEach(postViewModel.posts, id: \.id) { post in
                    VStack(alignment: .leading, spacing: 2) {
                        Text(post.title ?? "Unknown")
                            .foregroundColor(Color.appGreen)
                            .font(.system(size: 18, weight: .bold))
                        
                        Text(post.body ?? "Unknown")
                            .foregroundColor(Color.appGreen)
                            .font(.system(size: 14, weight: .bold))
                        
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
                    .padding(5)
                }
            }
            .listStyle(PlainListStyle())
        }
        .onAppear {
            postViewModel.getPostById(currentUser.userId)
        }
        .navigationBarTitle(currentUser.name ?? "Unknown")
        .navigationBarTitleDisplayMode(.inline)
        .greenNavigationBar()
    }
}
