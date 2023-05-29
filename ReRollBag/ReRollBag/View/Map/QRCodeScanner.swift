//
//  QRCodeScanner.swift
//  ReRollBag
//
//  Created by MacBook on 2023/05/01.
//
import AVFoundation

class QRCodeScanner: NSObject, AVCaptureMetadataOutputObjectsDelegate {
    var captureSession: AVCaptureSession?
    var previewLayer: AVCaptureVideoPreviewLayer?

    func setupQRCodeCaptureSession() {
        // 캡처 세션을 생성합니다.
        let captureSession = AVCaptureSession()
        
        // 카메라 장치를 찾습니다.
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            return
        }
        
        // 비디오 입력을 생성합니다.
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        // 캡처 세션에 비디오 입력을 추가합니다.
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            return
        }
        
        // 메타데이터 출력을 생성합니다.
        let metadataOutput = AVCaptureMetadataOutput()
        
        // 캡처 세션에 메타데이터 출력을 추가합니다.
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            
            // 메타데이터 출력에 대한 delegate를 설정합니다.
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            return
        }
        
        // 미리보기 레이어를 생성합니다.
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = .resizeAspectFill
        self.previewLayer = previewLayer
        
        // 캡처 세션을 시작합니다.
        captureSession.startRunning()
        self.captureSession = captureSession
    }
    
    func stopQRCodeCaptureSession() {
        captureSession?.stopRunning()
        captureSession = nil
        previewLayer?.removeFromSuperlayer()
        previewLayer = nil
    }
    
    // QR 코드 스캔 결과를 처리합니다.
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard let metadataObj = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
              let stringValue = metadataObj.stringValue else {
            return
        }
        
        // 스캔된 QR 코드 결과를 처리합니다.
        print(stringValue)
    }
}
