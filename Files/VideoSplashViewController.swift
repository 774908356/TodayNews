//
//  VideoSplashViewController.swift
//  ZCTodayNews
//
//  Created by chaozhang on 2017/11/24.
//  Copyright © 2017年 ZZC. All rights reserved.
//

import UIKit
import MediaPlayer
import AVKit

public enum ScalingMode {
    case resize
    case resizeAspect
    case resizeAspectFill
}

class VideoSplashViewController: UIViewController {

    fileprivate let moviePlayer = AVPlayerViewController()
    fileprivate var moviePlayerSoundLevel: Float = 1.0
    
    open var videoFrame:CGRect = CGRect()
    open var startTime:CGFloat = 0.0
    open var duration:CGFloat = 0.0
    open var backgroundColor: UIColor = UIColor.black {
        didSet {
            view.backgroundColor = backgroundColor
        }
    }
    
    open var contentURL:URL? {
        didSet {
            setMoviePlayer(contentURL!)
        }
    }
    
    
    open var sound:Bool = true {
        didSet {
            if sound {
                moviePlayerSoundLevel = 1.0
            }else{
                moviePlayerSoundLevel = 0.0
            }
        }
    }
    
    open var alpha:CGFloat = CGFloat() {
        didSet {
            moviePlayer.view.alpha = alpha
        }
    }
    
    open var alwaysRepeat:Bool = true {
        didSet {
            if alwaysRepeat {
                
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        // Do any additional setup after loading the view.
    }

    fileprivate func setMoviePlayer(_ url:URL) {
        let videoCutter = VideoCutter()
        videoCutter.cropVideoWithUrl(videoUrl: url, startTime: startTime, duration: duration) { (videoPath, error) -> Void in
            if let path = videoPath as URL? {
                DispatchQueue.global().async {
                    DispatchQueue.main.async {
                        self.moviePlayer.player = AVPlayer(url: path)
                        self.moviePlayer.player?.play()
                        self.moviePlayer.player?.volume = self.moviePlayerSoundLevel
                    }
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
