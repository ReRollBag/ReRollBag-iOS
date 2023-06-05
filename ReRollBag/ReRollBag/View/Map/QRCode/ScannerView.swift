//
//  ScannerView.swift
//  QRTest
//
//  Created by MacBook on 2023/06/03.
//

import SwiftUI
import AVKit

struct ScannerView: View {
    @State private var isScanning : Bool = false
    @State private var session: AVCaptureSession = .init()
    @State private var cameraPermission: Permission = .idle
    
    @State private var qrOutput: AVCaptureMetadataOutput = .init()
    
    @State private var errorMessage: String = ""
    @State private var showError: Bool = false
    @State private var scannedCode: String = ""
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.openURL) private var openURL
    @StateObject private var qrDelegate = QRScannerDelegate()
    @ObservedObject var rentVM: RentViewModel
    
    
    var body: some View {
        VStack(spacing: 8) {
            Button(action: {
                dismiss()
            }) {
                Image(systemName:  "xmark")
                    .font(.title)
                    .foregroundColor(Color("Green1"))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("영역안에 QR 코드를 놓아주세요.")
                .font(.title3)
                .foregroundColor(.black.opacity(0.8))
                .padding(.top,20)
            
            Text("스캔을 시작합니다.")
                .font(.callout)
                .foregroundColor(.gray)
            Spacer(minLength: 0)
            
            ///Scanner
            GeometryReader {
                let size = $0.size
                
                ZStack{
                    CameraView(frameSize: CGSize(width: size.width, height: size.width), session: $session)
                        .scaleEffect(0.97)
                    ForEach(0...4, id: \.self) { index in
                        let rotation = Double(index) * 90
                        RoundedRectangle(cornerRadius: 2, style: .circular)
                            .trim(from: 0.61, to: 0.64)
                            .stroke(Color("Green1"),style:  StrokeStyle(lineWidth: 5,lineCap: .round, lineJoin: .round))
                            .rotationEffect(.init(degrees: rotation))
                    }
                }
                //Sqaure Shape
                .frame(width: size.width, height: size.width)
                // Scanner Animation
                .overlay(alignment: .top){
                    Rectangle()
                        .fill(Color("Green1"))
                        .frame(height: 2.5)
                        .shadow(color: .black.opacity(0.8),radius: 8, x: 0, y: isScanning ? 15 : -15)
                        .offset(y: isScanning ? size.width : 0)
                }
                // To make it center
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .padding(.horizontal,45)
            
            Spacer(minLength: 15)
            
            Button(action: {
                if !session.isRunning && cameraPermission == .approved {
                    reactivateCamera()
                    activateScannerAnimation()
                }
            }) {
                Image(systemName: "qrcode.viewfinder")
                    .font(.largeTitle)
                    .foregroundColor(.gray)
            }
            
            Spacer(minLength: 45)
        }
        .padding(15)
        .navigationBarBackButtonHidden()
        .onAppear{
            checkCameraPermission()
        }
        .alert(errorMessage,isPresented: $showError){
            if cameraPermission == .denied {
                Button("Settings"){
                    let settingsString = UIApplication.openSettingsURLString
                    if let settingsURL = URL(string: settingsString) {
                        openURL(settingsURL)
                    }
                }
                
                Button("취소",role: .cancel){
                    
                }
            }
        }
        .onChange(of: qrDelegate.scannedCode) { newValue in
            if let code = newValue {
                scannedCode = code
                session.stopRunning()
                deActivateScannerAnimation()
                qrDelegate.scannedCode = nil
                
                rentVM.bagsId = code
                rentVM.updateRentingStatus(usersId: "testdy@test.com") //수정 필요
            }
        }
        .onChange(of: rentVM.rentState) { newValue in
            if newValue {
                dismiss()
            }else{
                presentError("Uncorrect QR Codes")
            }
        }
    }
    
    func reactivateCamera() {
        DispatchQueue.global(qos: .background).async {
            session.startRunning()
        }
    }
    
    func activateScannerAnimation() {
        withAnimation(.easeInOut(duration: 0.85).repeatForever(autoreverses: true)){
            isScanning = true
        }
    }
    
    func deActivateScannerAnimation() {
        withAnimation(.easeInOut(duration: 0.85)){
            isScanning = false
        }
    }
    
    func checkCameraPermission() {
        Task {
            switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized:
                cameraPermission = .approved
                if session.inputs.isEmpty {
                    setupCamera()
                }else{
                    session.stopRunning()
                }
            case .notDetermined:
                if await AVCaptureDevice.requestAccess(for: .video){
                    cameraPermission = .approved
                    setupCamera()
                }else{
                    cameraPermission = .denied
                    presentError("Please Provide Access to Camera for Scanning codes")
                }
            case .denied, .restricted:
                cameraPermission = .denied
                presentError("Please Provide Access to Camera for Scanning codes")
            default: break
            }
        }
    }
    
    /// Setting Up Camera
    func setupCamera() {
        do {
            guard let device = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera,.builtInUltraWideCamera], mediaType: .video, position: .back).devices.first else {
                presentError("Unknown Input Error")
                return
            }
            
            //Camera Input
            let input = try AVCaptureDeviceInput(device: device)
            guard session.canAddInput(input), session.canAddOutput(qrOutput) else {
                presentError("Unknown Input/Output Error")
                return
            }
            // Adding Input & output to Camera Session
            session.beginConfiguration()
            session.addInput(input)
            session.addOutput(qrOutput)
            
            //Setting Output config to read QR Codes
            qrOutput.metadataObjectTypes = [.qr]
            
            // Adding Delegate to Retreive the Fetched QR Code From Camera
            qrOutput.setMetadataObjectsDelegate(qrDelegate, queue: .main)
            session.commitConfiguration()
            // NoteSession must be started on Background thread
            DispatchQueue.global(qos: .background).async {
                session.startRunning()
            }
            activateScannerAnimation()
        } catch {
            presentError(error.localizedDescription)
        }
    }
    
    /// Presenting Error
    func presentError(_ message: String){
        errorMessage = message
        showError.toggle()
    }
}

//struct ScannerView_Previews: PreviewProvider {
//    static var previews: some View {
//        ScannerView()
//    }
//}
