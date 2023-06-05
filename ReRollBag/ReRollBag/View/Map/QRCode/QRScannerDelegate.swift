//
//  QRScannerDelegate.swift
//  QRTest
//
//  Created by MacBook on 2023/06/03.
//

import Foundation
import AVFoundation

class QRScannerDelegate: NSObject, ObservableObject, AVCaptureMetadataOutputObjectsDelegate {
    @Published var scannedCode: String?
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let metaObject = metadataObjects.first {
            guard let readableObject = metaObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let code = readableObject.stringValue else { return }
            print(code)
            scannedCode = code.replacingOccurrences(of: "RRB_", with: "")
        }
    }
}
