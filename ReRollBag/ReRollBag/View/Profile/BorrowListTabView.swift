////
////  BorrowListTabView.swift
////  ReRollBag
////
////  Created by MacBook on 2023/05/01.
////
//
//import SwiftUI
//
//struct BorrowListTabView: View {
//    //["전체","반납","대여중"]
//    @Binding var tabSelection : Int
//    @EnvironmentObject var bagStore : BagStore
//    var body: some View {
//        VStack{
//            TabView(selection: $tabSelection) {
//                CommunityPostListView(posts: communityStore.posts.filter({ cp in
//                    cp.postCategory == "전체"
//                })
//                ).tag(0)
//                CommunityPostListView(posts: communityStore.posts.filter({ cp in
//                    cp.postCategory == "대여중"
//                })
//                
//                ).tag(1)
//                CommunityPostListView(posts: communityStore.posts.filter({ cp in
//                    cp.postCategory == "반납"
//                })
//                
//                ).tag(2)
//                
//                ).tag(3)
//            }
//        }
//    }
//}
//
//struct BorrowListTabView_Previews: PreviewProvider {
//    @State static var tabSelection : Int = 0
//    static var previews: some View {
//        BorrowListTabView(tabSelection: $tabSelection)
//            .environmentObject(CommunityStore())
//    }
//}
