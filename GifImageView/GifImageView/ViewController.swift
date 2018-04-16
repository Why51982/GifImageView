//
//  ViewController.swift
//  GifImageView
//
//  Created by Ocean on 2018/4/16.
//  Copyright © 2018年 Ocean. All rights reserved.
//

import UIKit
import ImageIO

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 获取NSData类型
        guard let filePath = Bundle.main.path(forResource: "demo.gif", ofType: nil) else { return }
        guard let fileData = NSData(contentsOfFile: filePath) else { return }
        
        // 获取Data获取CGImageSource对象
        guard let imageSource = CGImageSourceCreateWithData(fileData, nil) else { return }
        
        // 获取GIF中图片的个数和时间
        let frameCount = CGImageSourceGetCount(imageSource)
        var duration: TimeInterval = 0
        var images: [UIImage] = [UIImage]()
        for i in 0 ..< frameCount {
            // 获取图片
            guard let cgImage = CGImageSourceCreateImageAtIndex(imageSource, i, nil) else { continue }
            let image = UIImage(cgImage: cgImage)
            if 0 == i {
                imageView.image = image
            }
            
            images.append(image)
            
            // 获取时长
            guard let properties = CGImageSourceCopyPropertiesAtIndex(imageSource, i, nil), let gifInfo = (properties as NSDictionary)[kCGImagePropertyGIFDictionary] as? NSDictionary, let frameDuration = gifInfo[kCGImagePropertyGIFDelayTime] as? NSNumber else { continue }
            duration += frameDuration.doubleValue
        }
        
        // 播放image
        imageView.animationImages = images
        imageView.animationDuration = duration
        imageView.animationRepeatCount = 0
        imageView.startAnimating()
    }


    @IBAction func startRuning(_ sender: UIButton) {
        
        imageView.startAnimating()
    }
    
    @IBAction func stopRuning(_ sender: UIButton) {
        
        imageView.stopAnimating()
    }
    
}

