//
//  CameraViewController.swift
//  TeemReel
//
//  Created by scott harris on 6/2/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController {
    lazy private var captureSession = AVCaptureSession()
    lazy private var fileOutput = AVCaptureMovieFileOutput()
    var cameraView = CameraPreviewView()
    var apiController: APIController?
    let apiClient = ApiClient()
    var prompt: Prompt?
    
    let recordButton: UIButton = {
        let button = UIButton()
        button.tintColor = .systemRed
        button.setBackgroundImage(UIImage(systemName: "largecircle.fill.circle"), for: .normal)
        button.setBackgroundImage(UIImage(systemName: "stop.circle"), for: .selected)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Resize camera preview to fill the entire screen
        cameraView.videoPlayerView.videoGravity = .resizeAspectFill
        
        setupCaptureSession()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        captureSession.startRunning()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        captureSession.stopRunning()
    }
    
    private func setupViews() {
        view.addSubview(cameraView)
        cameraView.addSubview(recordButton)
        recordButton.addTarget(self, action: #selector(recordTapped(_:)), for: .touchUpInside)
        
        cameraView.translatesAutoresizingMaskIntoConstraints = false
        recordButton.translatesAutoresizingMaskIntoConstraints = false
        cameraView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        cameraView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        cameraView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        cameraView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        recordButton.widthAnchor.constraint(equalToConstant: 105).isActive = true
        recordButton.heightAnchor.constraint(equalToConstant: 105).isActive = true
        recordButton.centerXAnchor.constraint(equalTo: cameraView.centerXAnchor).isActive = true
        recordButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
        
    }
    
    private func setupCaptureSession() {
        captureSession.beginConfiguration()
        
        // Add inputs
        let camera = bestCamera()
        
        // Video
        guard let captureInput = try? AVCaptureDeviceInput(device: camera),
            captureSession.canAddInput(captureInput) else {
                fatalError("Can't create input from the camera")
        }
        captureSession.addInput(captureInput)
        
        if captureSession.canSetSessionPreset(.hd1920x1080) {
            captureSession.sessionPreset = .hd1920x1080
        }
        
        // Audio
        let microphone = bestAudio()
        guard let audiInput = try? AVCaptureDeviceInput(device: microphone),
            captureSession.canAddInput(audiInput) else {
                fatalError("cant create microphone input")
        }
        captureSession.addInput(audiInput)
        
        
        // File output
        guard captureSession.canAddOutput(fileOutput) else {
            fatalError("Cannot record to disk")
        }
        captureSession.addOutput(fileOutput)
        
        
        // Recording to disk
        captureSession.commitConfiguration()
        
        // Live preview
        cameraView.session = captureSession
        
        // Try to change video container codec to h264 to create an MP4 instead of a MOV File
        let connection = fileOutput.connection(with: .video)
        if fileOutput.availableVideoCodecTypes.contains(.h264), let connection = connection {
            fileOutput.setOutputSettings([AVVideoCodecKey: AVVideoCodecType.h264], for: connection)
        }
    }
    
    private func bestCamera() -> AVCaptureDevice {
        // All iphones have a wide angle camera (front + back)
        if let ultraWideCamera = AVCaptureDevice.default(.builtInUltraWideCamera, for: .video, position: .front) {
            return ultraWideCamera
        }
        
        if let wideCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) {
            return wideCamera
        }
        
        fatalError("No cameras on the device (or you're running it on the simulator which isnt suported")
        
    }
    
    private func bestAudio() -> AVCaptureDevice {
        if let device = AVCaptureDevice.default(for: .audio) {
            return device
        }
        fatalError("No audio")
    }
    
    private func newRecordingURL() -> URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime]
        
        let name = formatter.string(from: Date())
        let fileURL = documentsDirectory.appendingPathComponent(name).appendingPathExtension("mp4")
        return fileURL
    }
    
    private func updateViews() {
        recordButton.isSelected = fileOutput.isRecording
    }
    
    @objc func recordTapped(_ sender: Any) {
        if fileOutput.isRecording {
            fileOutput.stopRecording()
        } else {
            fileOutput.startRecording(to: newRecordingURL(), recordingDelegate: self)
        }
    }
    
}

extension CameraViewController: AVCaptureFileOutputRecordingDelegate {
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        print("did finish recording")
        if let error = error {
            print("Video recording error: \(error)")
        } else {
            guard let bearer = apiController?.bearer, let prompt = prompt else { return }
            // ADD DELEGATE METHOD!!
//            delegate?.videoFinished(url: outputFileURL)
            
            let videoVC = VideoReponseViewController()
            let parentVC = self.presentingViewController as? NavigationController

            parentVC?.pushViewController(videoVC, animated: false)
            dismiss(animated: true) {
                videoVC.videoURL = outputFileURL
                videoVC.bearer = bearer
                videoVC.promptId = prompt.id
            }
            
            
        }
    }
    
    func fileOutput(_ output: AVCaptureFileOutput, didStartRecordingTo fileURL: URL, from connections: [AVCaptureConnection]) {
        print("did start recording: \(fileURL)")
        updateViews()
        
    }
}
