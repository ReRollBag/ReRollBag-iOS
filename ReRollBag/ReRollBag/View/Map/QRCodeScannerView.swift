//
//  QRReaderView.swift
//  ReRollBag
//
//  Created by MacBook on 2023/05/01.
//

import SwiftUI
import AVFoundation

struct QRCodeScannerView: UIViewRepresentable {
    let scanner = QRCodeScanner()

    func makeUIView(context: Context) -> UIView {
        // UIView를 생성하여 AVCaptureVideoPreviewLayer를 추가합니다.
        let view = UIView()
        if let previewLayer = scanner.previewLayer {
            view.layer.addSublayer(previewLayer)
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        // 뷰가 업데이트될 때 카메라 캡처 세션을 시작합니다.
        scanner.setupQRCodeCaptureSession()
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject {
        let parent: QRCodeScannerView

        init(_ parent: QRCodeScannerView) {
            self.parent = parent
        }
    }
}
