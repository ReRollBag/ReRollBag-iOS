//
//  SignUpView.swift
//  ReRollBag
//
//  Created by MacBook on 2023/02/28.
//

import SwiftUI

struct SignUpView: View {
    @State private var email = ""
    @State private var pw = ""
    @State private var checkPw = ""
    @State private var name = ""
    @State private var phoneNumber = ""
    @State private var certificationNumber = ""
    
    @State private var isDuplicated = false
    @State private var isShowingPw = false
    @State private var isShowingCheckPw = false
    
    //연산프로퍼티
    
    private var isNotIncludedEnglish:  Bool {
        for c in pw {
            if c.isLetter {
                return true
            }
        }
        return false
    }
    private var isNotIncludedNumber:  Bool {
        for c in pw {
            if c.isNumber {
                return true
            }
        }
        return false
    }
    private var isNotLimitedLength:  Bool {
        if pw.count < 8 || pw.count > 20 {
            return false
        }
        return true
    }
    
    private var isPwSameCheck : Bool {
        if !isNotIncludedEnglish || !isNotIncludedNumber || !isNotLimitedLength {
            return false
        }else {
            if pw == checkPw {
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
                        TextField("이메일", text: $email)
                            .textFieldStyle(.plain)
                            .frame(maxWidth: .infinity)
                            .padding(.top,10)
                        
                        Divider()
                    }
                    Button(action: {
                        isDuplicated.toggle()
                    }) {
                        Text("중복확인")
                            .foregroundColor(Color(isDuplicated ? "Green1": "Gray2"))
                            .overlay {
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color(isDuplicated ? "Green1": "Gray2"), lineWidth: 1).frame(width:90,height: 35)
                                
                            }
                    }.frame(width:100)
                    
                }//HStack
            }
            
            // MARK: - 비밀번호 입력 뷰
            Group{
                Text("비밀번호")
                    .font(.footnote)
                    .padding(.top,10)
                
                TextField("비밀번호", text: $pw)
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
                
                TextField("비밀번호 확인", text: $checkPw)
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
                
                TextField("이름", text: $name)
                    .textFieldStyle(.plain)
                    .frame(maxWidth: .infinity)
                    .padding(.top,10)
                
                Divider()
            }
            // MARK: - 휴대폰 번호 입력 뷰
            
            Group{
                Text("휴대폰 번호")
                    .font(.footnote)
                    .padding(.top,10)
                HStack{
                    VStack{
                        TextField("휴대폰 번호", text: $phoneNumber)
                            .textFieldStyle(.plain)
                            .frame(maxWidth: .infinity)
                            .padding(.top,10)
                        
                        Divider()
                    }
                    Button(action: {
                        isDuplicated.toggle()
                    }) {
                        Text("인증 요청")
                            .foregroundColor(Color(isDuplicated ? "Green1": "Gray2"))
                            .padding()
                            .overlay {
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color(isDuplicated ? "Green1": "Gray2"), lineWidth: 1).frame(width:90 ,height: 35)
                                
                            }
                    }.frame(width:100)
                    
                }//HStack
            }
            // MARK: - 인증번호 입력 뷰
            
            Group{
                Text("인증번호 확인")
                    .font(.footnote)
                    .padding(.top,10)
                HStack{
                    VStack{
                        TextField("인증번호", text: $certificationNumber)
                            .textFieldStyle(.plain)
                            .frame(maxWidth: .infinity)
                            .padding(.top,10)
                        
                        Divider()
                    }
                    Button(action: {
                        isDuplicated.toggle()
                    }) {
                        Text("확인")
                            .foregroundColor(Color(isDuplicated ? "Green1": "Gray2"))
                            .padding()
                            .overlay {
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color(isDuplicated ? "Green1": "Gray2"), lineWidth: 1).frame(width:90,height: 35)
                                
                            }
                    }.frame(width:100)
                    
                }//HStack
                .padding(.bottom,30)
                
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
            }
        }
        .padding(30)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    
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
    static var previews: some View {
        NavigationView{
            SignUpView()
        }
    }
}
