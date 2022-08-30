//
//  PostCellToolbarButton.swift
//  WeChatHomeView
//
//  Created by Andy on 2022/8/25.
//

import SwiftUI

struct PostCellToolbarButton: View {
    let image: String
    let text: String
    let color: Color
    let action: () -> Void  //closure 闭包

    var body: some View {
        Button(action: action) {
            HStack(spacing:5) {
                Image(systemName: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 18, height: 18)
                Text(text)
                    .font(.system(size: 15))
            }
        }
        .foregroundColor(color)
        .buttonStyle(BorderlessButtonStyle())
    }
}

struct PostCellToolbarButton_Previews: PreviewProvider {
    static var previews: some View {
        PostCellToolbarButton(image: "heart", text: "点赞", color: .red) {
            print("dianzan")
        }
    }
}
