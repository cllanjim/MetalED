//
//  VideoViewController.swift
//  MetalED
//
//  Created by Henrik Akesson on 30/07/2016.
//  Copyright © 2016 Henrik Akesson. All rights reserved.
//

import UIKit

class VideoViewController: UIViewController {
    
    var video:Video!
    let videoView = VideoView(frame: CGRectZero)
    let buffer = VideoBuffer()
    var timer: NSTimer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(videoView)
        timer = NSTimer.scheduledTimerWithTimeInterval(Double(1.0/video.frameRate), target: self, selector: #selector(VideoViewController.nextFrame), userInfo: nil, repeats: true)
        
        nextFrame()
        /*
        camera.delegate = videoView.videoBuffer
        camera.running = true
        */
    }
    
    func nextFrame() {
        if let frame = video.nextFrame() {
            buffer.captureBuffer(frame)
        } else {
            timer?.invalidate()
            print("Finished video")
        }
    }
    
    override func viewDidLayoutSubviews() {
        videoView.frame = view.bounds
        videoView.drawableSize = CGSize(width: view.bounds.width * 2, height: view.bounds.height * 2)
        print("frame: \(videoView.frame) drawableSize: \(videoView.drawableSize)")
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return .LandscapeLeft
    }
}