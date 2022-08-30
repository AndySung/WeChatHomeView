//
//  HomeView.swift
//  WeChatHomeView
//
//  Created by Andy on 2022/8/26.
//

import SwiftUI

struct HomeView: View {
    @State var leftPercent: CGFloat = 0
    /*init() {
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().selectionStyle = .none
    }*/

    var body: some View {
        NavigationView {
            GeometryReader { gometry in
                HScrollViewController(pageWith: gometry.size.width, contentSize: CGSize(width: gometry.size.width * 2, height: gometry.size.height), leftPercent: self.$leftPercent) {
                    HStack(spacing: 0 ) {
                        PostListView(category: .recommend)
                            .frame(width: UIScreen.main.bounds.width)
                        PostListView(category: .hot)
                            .frame(width: UIScreen.main.bounds.width)
                    }.edgesIgnoringSafeArea(.bottom)
                }

            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarItems(leading: HomeNavigationBar(leftPercent: $leftPercent))
            .navigationBarTitle("首页", displayMode: .inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())    //让iPad上的布局和iPhone上一致
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(UserData.testData)
    }
}
