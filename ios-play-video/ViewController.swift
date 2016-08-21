//
//  ViewController.swift
//  ios-play-video
//
//  Created by Zhaonan Li on 8/21/16.
//  Copyright © 2016 Zhaonan Li. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var playVideoBtn: UIButton!
    @IBOutlet weak var selectVideoBtn: UIButton!
    @IBOutlet weak var pauseVideoBtn: UIButton!
    
    var videoUrl: NSURL?
    
    lazy var videoPickerController: UIImagePickerController = {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self;
        pickerController.sourceType = .PhotoLibrary
        pickerController.mediaTypes = ["public.movie"]
        // pickerController.mediaTypes = ["public.image", "public.movie"]
        return pickerController
    }()

    lazy var avPlayer: AVPlayer = {
        let avPlayer = AVPlayer()
        return avPlayer
    }()
    
    lazy var avPlayerLayer: AVPlayerLayer = {
        let avPlayerLayer = AVPlayerLayer(player: self.avPlayer)
        return avPlayerLayer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        self.avPlayerLayer.backgroundColor = UIColor.blackColor().CGColor
        self.avPlayerLayer.frame = CGRectMake(0, 0, self.videoView.frame.width, self.videoView.frame.height)
        self.videoView.layer.insertSublayer(self.avPlayerLayer, atIndex: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func playVideo(sender: AnyObject) {
        if self.videoUrl == nil {
            print("ERROR:videoUrl is nil")
            return
        }
        
        print("DEBUG:videoUrl=\(self.videoUrl)")
        
        let avPlayerItem: AVPlayerItem = AVPlayerItem(URL: self.videoUrl!)
        self.avPlayer.replaceCurrentItemWithPlayerItem(avPlayerItem)
        self.avPlayer.play()
    }
    
    @IBAction func selectVideo(sender: AnyObject) {
        presentViewController(self.videoPickerController, animated: true, completion: nil)
    }
    
    @IBAction func pauseVideo(sender: AnyObject) {
        self.avPlayer.pause()
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        self.videoUrl = info["UIImagePickerControllerReferenceURL"] as? NSURL
        
        print(self.videoUrl)
        self.videoPickerController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

