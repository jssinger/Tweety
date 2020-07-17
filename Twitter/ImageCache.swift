//
//  TwitterImageCache.swift
//  Twitter
//
//  Created by Jonathan Singer on 7/16/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import Foundation
import UIKit

class ImageCache{
    static let cache = ImageCache()
    var imageDict: [URL: UIImage] = [URL: UIImage]()
    
    func getImageForURL(url: URL, success: @escaping (UIImage) -> (), failure: @escaping () -> ()){
        
        if let image = imageDict[url] {
            success(image)
            return
        }
        
        let data = try? Data(contentsOf: url)
        
        if (data == nil) {
            failure()
            return
        }
        
        let image = UIImage(data: data!)
        
        if (image == nil) {
            failure()
            return
        }
        
        imageDict[url] = image
        success(image!)
        
    }
}

