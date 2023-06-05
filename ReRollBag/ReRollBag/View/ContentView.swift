//
//  ContentView.swift
//  ReRollBag
//
//  Created by MacBook on 2023/02/28.
//

import SwiftUI

struct ContentView: View {
    @State private var tabSelection = 0
    
    var body: some View {
            MapView()
            .navigationBarBackButtonHidden()
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
