//
//  PostListView.swift
//  WeChatHomeView
//
//  Created by Andy on 2022/8/25.
//

import SwiftUI
import BBSwiftUIKit

struct PostListView: View {

    let category: PostListCategory

//    var postList: PostList {
//        switch category {
//        case .recommend:
//            return loadPostListData("PostListData_recommend_1.json")
//        case .hot:
//            return loadPostListData("PostListData_hot_1.json")
//        }
//    }
    @EnvironmentObject var userData: UserData


    var body: some View {
        BBTableView(userData.postList(for: category).list) { post in
            NavigationLink(destination: PostDetailView(post: post)){
                PostCell(post: post)
            }
            .buttonStyle(OriginalButtonStyle())
           /* ForEach(userData.postList(for: category).list) { post in
                ZStack {
                    PostCell(post: post)
                    NavigationLink(destination: PostDetailView(post: post)){
                        EmptyView()
                    }.hidden()
                }
                .listRowInsets(EdgeInsets())
            }*/
        }
        .bb_setupRefreshControl({ control in
            control.attributedTitle = NSAttributedString(string: "loading...")
        })
        .bb_pullDownToRefresh(isRefreshing: $userData.isRefreshing) {
            self.userData.refreshPostList(for:  self.category)
//            print("Refresh")
//            self.userData.loadingError = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "刷新错误，网络连接失败（Test）"])

            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.userData.isRefreshing = false
            }
        }
        .bb_pullUpToLoadMore(bottomSpace: 30) {
            self.userData.loadMorePostList(for: self.category)
//            if self.userData.isLoadingMore { return }
//            self.userData.isLoadingMore = true
//            print("load more")
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                self.userData.isLoadingMore = false
//            }
        }
        .bb_reloadData($userData.reloadData)
        .onAppear {
            self.userData.loadPostListIfNeeded(for: self.category)
        }
        .overlay(
            Text(userData.loadingErrorText)
                .bold()
                .frame(width: 200)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.white)
                        .opacity(0.8)
                )
                .animation(nil)
                .scaleEffect(userData.showLoadingError ? 1 : 0.5)
                .animation(.spring(response: 0.5))
                .opacity(userData.showLoadingError ? 1 : 0)
                .animation(.easeInOut)
        )
    }

}

struct PostListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PostListView(category: .recommend)
                .navigationBarTitle("Title")
                .navigationBarHidden(true)
        }
        .environmentObject(UserData.testData)
    }
}
