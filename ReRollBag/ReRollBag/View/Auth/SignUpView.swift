//
//  SignUpView.swift
//  ReRollBag
//
//  Created by MacBook on 2023/02/28.
//

import SwiftUI

struct SignUpView: View {
    @StateObject var signUpVM = SignUpViewModel()
    @Binding var authState : AuthState
    
    @State private var isDuplicatedBtnTapped = false
    @State private var isDuplicated = true
    @State private var isShowingPw = false
    @State private var isShowingCheckPw = false
    
    //연산프로퍼티
    
    private var isNotIncludedEnglish:  Bool {
        for c in signUpVM.pw {
            if c.isLetter {
                return true
            }
        }
        return false
    }
    private var isNotIncludedNumber:  Bool {
        for c in signUpVM.pw {
            if c.isNumber {
                return true
            }
        }
        return false
    }
    private var isNotLimitedLength:  Bool {
        if signUpVM.pw.count < 8 || signUpVM.pw.count > 20 {
            return false
        }
        return true
    }
    
    private var isPwSameCheck : Bool {
        if !isNotIncludedEnglish || !isNotIncludedNumber || !isNotLimitedLength {
            return false
        }else {
            if signUpVM.pw == signUpVM.checkPw {
                return true
            }else{
                return false
            }
        }
    }
    
    
    // MARK: - SignUpView
    var body: some View {
        VStack(alignment: .leading){
            // MARK: - 이메일 입력 뷰
            Group{
                Text("이메일")
                    .font(.footnote)
                    .padding(.top,10)
                HStack{
                    VStack{
                        TextField("이메일", text: $signUpVM.email)
                            .textFieldStyle(.plain)
                            .frame(maxWidth: .infinity)
                            .padding(.top,10)
                        
                        Divider()
                    }
                    Button(action: {
                        signUpVM.checkEmailDuplicated()
                        print("중복확인 버튼 클릭 \(signUpVM.isDuplicated)")
                    }) {
                        Text("중복확인")
                            .foregroundColor(Color(isDuplicated ? "Gray2": "Green1"))
                            .overlay {
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color(isDuplicated ? "Gray2": "Green1"), lineWidth: 1).frame(width:90,height: 35)
                                
                            }
                    }.frame(width:100)
                    
                }//HStack
                Text(isDuplicated ? "" : "중복된 이메일입니다")
                    .foregroundColor(.red)
                    .frame(height: 10)
                    .font(.caption)
            }
            
            // MARK: - 비밀번호 입력 뷰
            Group{
                Text("비밀번호")
                    .font(.footnote)
                    .padding(.top,10)
                
                TextField("비밀번호", text: $signUpVM.pw)
                    .textFieldStyle(.plain)
                    .frame(maxWidth: .infinity)
                    .padding(.top,10)
                    .overlay {
                        VStack{
                            Spacer()
                            HStack{
                                Spacer()
                                Button(action: {
                                    isShowingPw.toggle()
                                }) {
                                    Image(systemName: isShowingPw ? "eye.slash": "eye")
                                }
                                .foregroundColor(Color("Gray2"))
                            }
                        }
                    }
                CustomDivider(isNotIncludedEnglish && isNotIncludedNumber && isNotLimitedLength)
                
                HStack{
                    Text("영문 포함")
                        .foregroundColor(Color(isNotIncludedEnglish ? "Green1": "Gray2"))
                    Image(systemName: "checkmark")
                        .foregroundColor(Color(isNotIncludedEnglish ? "Green1": "Gray2"))
                    Text("숫자 포함")
                        .foregroundColor(Color(isNotIncludedNumber ? "Green1": "Gray2"))
                    Image(systemName: "checkmark")
                        .foregroundColor(Color(isNotIncludedNumber ? "Green1": "Gray2"))
                    Text("8~20자 이내")
                        .foregroundColor(Color(isNotLimitedLength ? "Green1": "Gray2"))
                    Image(systemName: "checkmark")
                        .foregroundColor(Color(isNotLimitedLength ? "Green1": "Gray2"))
                }
                .font(.caption)
            }
            
            
            // MARK: - 비밀번호 확인 입력 뷰
            Group{
                Text("비밀번호 확인")
                    .font(.footnote)
                    .padding(.top,10)
                
                TextField("비밀번호 확인", text: $signUpVM.checkPw)
                    .textFieldStyle(.plain)
                    .frame(maxWidth: .infinity)
                    .padding(.top,10)
                    .overlay {
                        VStack{
                            Spacer()
                            HStack{
                                Spacer()
                                Button(action: {
                                    isShowingCheckPw.toggle()
                                }) {
                                    Image(systemName: isShowingCheckPw ? "eye.slash": "eye")
                                }
                                .foregroundColor(Color("Gray2"))
                            }
                        }
                    }
                
                CustomDivider(isPwSameCheck)
                
                Text(isPwSameCheck ? "비밀번호가 일치합니다." : "")
                    .foregroundColor(Color(isPwSameCheck ? "Green1": "Gray2"))
                    .frame(height: 10)
                    .font(.caption)
            }
            
            
            // MARK: - 이름 입력 뷰
            Group{
                Text("이름")
                    .font(.footnote)
                    .padding(.top,10)
                
                TextField("이름", text: $signUpVM.name)
                    .textFieldStyle(.plain)
                    .frame(maxWidth: .infinity)
                    .padding(.top,10)
                
                Divider()
            }
            
            NavigationLink(destination: EmptyView()) {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color("Green1"))
                    .frame(height: 55)
                
                    .overlay {
                        Text("회원가입")
                            .font(.title3)
                            .foregroundColor(.white)
                    }
            }
            .padding(.top,30)
            Spacer()
        }
        .padding(30)
        
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    authState = .signIn(true)
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(Color("Green1"))
                }
            }
            
            ToolbarItem(placement: .principal) {
                Text("회원가입")
                    .foregroundColor(Color("Green1"))
                    .font(.headline)
            }
       }
    }
    
    /// by 조건에 따라 색깔이 바뀌는 Custom Divider
    @ViewBuilder
    private func CustomDivider(_ by : Bool) -> some View {
        Rectangle().frame(height:1)
            .foregroundColor(Color(by ? "Green1" : "Gray1"))
    }
    
}



struct SignUpView_Previews: PreviewProvider {
    @State static var authState : AuthState = .signUp
    
    static var previews: some View {
        NavigationView{
            SignUpView(authState: $authState)
        }
    }
}
