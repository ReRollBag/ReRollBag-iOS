//
//  ContentView.swift
//  ReRollBag
//
//  Created by MacBook on 2023/02/28.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var tabSelection = 0
    
    var body: some View {
        TabView(selection: $tabSelection) {
            MapView()
                .tabItem {
                    Image(systemName: "map")
                    Text("대여")
                }
            ProfileView()
                .tabItem {
                    Image(systemName: "person.circle")
                    Text("프로필")
                }
            
        }
        
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
