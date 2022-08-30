//
//  PostDetailView.swift
//  WeChatHomeView
//
//  Created by Andy on 2022/8/25.
//

import SwiftUI
import BBSwiftUIKit

struct PostDetailView: View {
    let post: Post
    var body: some View {
        BBTableView(0...10) { i in
            if i == 0 {
                PostCell(post: post)
            } else {
                HStack {
                    Text("评论\(i)").padding()
                    Spacer()
                }

            }
            /*PostCell(post: post)
                .listRowInsets(EdgeInsets())
            ForEach(1...10, id: \.self) {i in
                Text("评论\(i)")
            }*/
        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarTitle("详情", displayMode:.inline)
    }
}

struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
//        PostDetailView(post: postList.list[0])
        let userData = UserData.testData
        return PostDetailView(post:  userData.recommendPostList.list[0]).environmentObject(userData)
    }
}
