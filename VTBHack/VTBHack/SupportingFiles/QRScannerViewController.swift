//
//  QRScannerViewController.swift
//  VTBHack
//
//  Created by Nikita Arutyunov on 14.09.2019.
//  Copyright © 2019 RxProject. All rights reserved.
//

import UIKit
import AVFoundation

class QRScannerViewController: UIViewController {
  
  let captureSession = AVCaptureSession()
  let metadataOutput = AVCaptureMetadataOutput()
  
  override func viewDidLoad() {
    
    guard let videoCaptureDevice = AVCaptureDevice.default(for: .video),
      let videoInput = try? AVCaptureDeviceInput(device: videoCaptureDevice) else { return scanningError() }
    
    guard captureSession.canAddInput(videoInput) else { return scanningError() }
    
    captureSession.addInput(videoInput)
    
    guard captureSession.canAddOutput(metadataOutput) else { return scanningError() }
    
    captureSession.addOutput(metadataOutput)
    
    metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
    metadataOutput.metadataObjectTypes = [.ean8, .ean13, .pdf417]
    
    let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
    previewLayer.frame = .zero
    previewLayer.videoGravity = .resizeAspectFill
    
    captureSession.startRunning()
    
    view.layer.addSublayer(previewLayer)
    
  }
    
  func scanningError() {
    
    let alert = UIAlertController(title: "Ошибка", message: "Чтения QR", preferredStyle: .alert)
    
    present(alert, animated: true, completion: nil)
    
  }
  
}

extension QRScannerViewController: AVCaptureMetadataOutputObjectsDelegate {
  
  func metadataOutput(_ output: AVCaptureMetadataOutput,
                      didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
    
    captureSession.stopRunning()
    
    guard let metadataObject = metadataObjects.first,
      let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject,
      let code = readableObject.stringValue else { return }
    
    AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
    
    let alert = UIAlertController(title: "QR", message: code, preferredStyle: .alert)
    
    present(alert, animated: true, completion: nil)
    
  }
  
}
