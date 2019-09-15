//
//  QRCodeScanViewController.swift
//  VTBHack
//
//  Created by Кирилл Володин on 15/09/2019.
//  Copyright © 2019 RxProject. All rights reserved.
//

import AVKit
import UIKit
import Vision

protocol QRCodeScanViewControllerDelegate: class {
    func didScanQRCode(rawString: String)
}

class QRCodeScanViewController: UIViewController {
    
    @IBOutlet var previewView: VideoPreviewView!
    
    @IBAction func selectPreview(_ sender: UITapGestureRecognizer) {
        snapPhoto()
    }
    
    var captureSession: AVCaptureSession!
    
    var capturePhotoOutput: AVCapturePhotoOutput!
    
    var isCaptureSessionConfigured = false
    
    weak var delegate: QRCodeScanViewControllerDelegate?
    
    private func configureCaptureSession() {
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: AVMediaType.video) else {
            print("Unable to find capture device")
            return
        }
        
        guard let videoInput = try? AVCaptureDeviceInput(device: videoCaptureDevice) else {
            print("Unable to obtain video input")
            return
        }
        
        capturePhotoOutput = AVCapturePhotoOutput()
        capturePhotoOutput.isHighResolutionCaptureEnabled = true
        capturePhotoOutput.isLivePhotoCaptureEnabled = capturePhotoOutput.isLivePhotoCaptureSupported
        
        guard captureSession.canAddInput(videoInput) else {
            print("Unable to add input")
            return
        }
        
        guard captureSession.canAddOutput(capturePhotoOutput) else {
            print("Unable to add output")
            return
        }
        
        captureSession.beginConfiguration()
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
        captureSession.addInput(videoInput)
        captureSession.addOutput(capturePhotoOutput)
        captureSession.commitConfiguration()
    }
    
    private func snapPhoto() {
        guard let capturePhotoOutput = self.capturePhotoOutput else { return }
        guard let captureConnection = previewView.videoPreviewLayer.connection else { return }
        
        if let photoOutputConnection = capturePhotoOutput.connection(with: AVMediaType.video) {
            photoOutputConnection.videoOrientation = captureConnection.videoOrientation
        }
        
        let photoSettings = AVCapturePhotoSettings()
        photoSettings.isAutoStillImageStabilizationEnabled = true
        photoSettings.isHighResolutionPhotoEnabled = true
        photoSettings.flashMode = .auto
        
        capturePhotoOutput.capturePhoto(with: photoSettings, delegate: self)
    }
    
    private func scanImage(cgImage: CGImage) {
        let barcodeRequest = VNDetectBarcodesRequest(completionHandler: { request, error in
            self.reportResults(results: request.results)
        })
        
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [.properties : ""])
        
        guard let _ = try? handler.perform([barcodeRequest]) else {
            return print("Could not perform barcode-request!")
        }
    }
    
    private func reportResults(results: [Any]?) {
        
        guard let results = results else {
            return print("No results found.")
        }
        
        for result in results {
            
            if let barcode = result as? VNBarcodeObservation {
                
                if let payload = barcode.payloadStringValue {
                    print("Payload: \(payload)")
                    delegate?.didScanQRCode(rawString: payload)
                    dismiss(animated: true, completion: nil)
                }
                
            }
        }
    }
}

// MARK: UIViewControllerDelegate

extension QRCodeScanViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        captureSession = AVCaptureSession()
        previewView.session = captureSession
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isCaptureSessionConfigured {
            if !captureSession.isRunning {
                captureSession.startRunning()
            }
        } else {
            configureCaptureSession()
            isCaptureSessionConfigured = true
            captureSession.startRunning()
            previewView.updateVideoOrientationForDeviceOrientation()
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if captureSession.isRunning {
            captureSession.stopRunning()
        }
    }
}

// MARK: AVCapturePhotoCaptureDelegate

extension QRCodeScanViewController : AVCapturePhotoCaptureDelegate {
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
//        print("Finished processing photo")
        
        guard let cgImageRef = photo.cgImageRepresentation() else {
            return print("Could not get image representation")
        }
        
        let cgImage = cgImageRef.takeUnretainedValue()
        
//        print("Scanning image")
        scanImage(cgImage: cgImage)
    }
}
