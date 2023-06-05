//
//  AdminSignInView.swift
//  ReRollBag
//
//  Created by MacBook on 2023/06/04.
//

import SwiftUI

struct AdminSignInView: View {
    @State var email: String = ""
    @State var pw: String = ""
    
    var body: some View {
        VStack(alignment: .leading){
            TextField("email", text: $email)
            
            TextField("pw", text: $pw)
            
            Button(action: {
                Task{
                    try await SignUpViewModel().signIn(email: email, password: pw)
                }
            }) {
                Rectangle()
                    .frame(height: 80)
            }
        }
    }
}

struct AdminSignInView_Previews: PreviewProvider {
    static var previews: some View {
        AdminSignInView()
    }
}
