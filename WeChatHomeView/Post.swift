//
//  Post.swift
//  WeChatHomeView
//
//  Created by Andy on 2022/8/25.
//

import Foundation
import UIKit
import SwiftUI
import SDWebImageSwiftUI

struct PostList: Codable {
    var list: [Post]
}

struct Post : Codable, Identifiable {
    let id: Int
    let avatar: String  //头像，图片名称
    let vip: Bool
    let name: String
    let date: String
    var isFollowed: Bool

    let text: String
    let images: [String]

    var commentCount: Int
    var likeCount: Int
    var isLiked: Bool
}

extension Post: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}

extension Post {
    var avatarImage: WebImage {
        loadImage(name: avatar)
    }

    var commentCountText: String {
        if commentCount <= 0 {return "评论"}
        if commentCount <= 1000 {return "\(commentCount)"}
        return String(format: "%.1fK", Double(commentCount) / 1000)
    }

    var likeCountText: String {
        if commentCount <= 0 {return "点赞"}
        if commentCount <= 1000 {return "\(likeCount)"}
        return String(format: "%.1fK", Double(likeCount) / 1000)
    }
}

//let postList = loadPostListData("PostListData_recommend_1.json")

//解析微博数据文件
func loadPostListData(_ fileName: String) -> PostList {
    guard let url = Bundle.main.url(forResource: fileName, withExtension: nil) else {
        fatalError("Can not find \(fileName) in main bu ndle")
    }
    guard let data = try? Data(contentsOf: url) else {
        fatalError("Can not load \(url)")
    }
    guard let list = try? JSONDecoder().decode(PostList.self, from: data) else {
        fatalError("Can not parse post list json data")
    }
    return list
}

func loadImage(name: String) -> WebImage {
    WebImage(url: URL(string: NetworkAPIBaseURL + name))
        .placeholder{ Color.gray }
}
