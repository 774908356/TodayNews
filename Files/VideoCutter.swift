//
//  VideoCutter.swift
//  ZCTodayNews
//
//  Created by chaozhang on 2017/11/24.
//  Copyright © 2017年 ZZC. All rights reserved.
//

import UIKit
import AVFoundation

extension String {
    var conver: NSString {return (self as NSString)}
}


 open class VideoCutter: NSObject {
    

    open func cropVideoWithUrl(videoUrl url:URL, startTime:CGFloat, duration: CGFloat, completion:((_ videoPath:URL?, _ error:NSError?) -> Void)?) {
        DispatchQueue.global().async {
            let asset = AVURLAsset(url: url, options: nil)
            let exportSession = AVAssetExportSession(asset: asset, presetName: "AVAssetExportPresetHighestQuality")
            let paths:NSArray = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
            var outputURL = paths.object(at: 0) as! String
            let manager = FileManager.default
            do {
                try manager.createDirectory(atPath: outputURL, withIntermediateDirectories: true, attributes: nil)
            } catch _ {
                
            }
            outputURL = outputURL.conver.appendingPathComponent("output.mp4")
            do{
                try manager.removeItem(atPath: outputURL)
            } catch _ {
                
            }
            if let exportSession = exportSession as AVAssetExportSession? {
                exportSession.outputURL = URL(fileURLWithPath: outputURL)
                exportSession.shouldOptimizeForNetworkUse = true
                exportSession.outputFileType = AVFileType.mp4
                let start = CMTimeMakeWithSeconds(Float64(startTime), 600)
                let duration = CMTimeMakeWithSeconds(Float64(duration), 600)
                let range = CMTimeRangeMake(start, duration)
                exportSession.timeRange = range
                exportSession.exportAsynchronously {() -> Void in
                    switch exportSession.status {
                    case AVAssetExportSessionStatus.completed:
                        completion?(exportSession.outputURL, nil)
                    case AVAssetExportSessionStatus.failed:
                        print("Failed")
                    case AVAssetExportSessionStatus.cancelled:
                        print("Cancel")
                    default:
                        print("Default Case")
                    }
                }
                
            }
            DispatchQueue.main.async {
                
            }
        }
    }
    
}
