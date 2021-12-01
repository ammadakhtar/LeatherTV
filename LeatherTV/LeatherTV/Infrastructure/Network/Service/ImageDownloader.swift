//
//  ImageDownloader.swift
//  LeatherTV
//
//  Created by Ammad Akhtar on 01/12/2021.
//

import Foundation
import UIKit

final class ImageDownloader {
    private static var imageCache = NSCache<AnyObject, AnyObject>()
    
    class func getImage(urlString: String, completion: @escaping (UIImage?) -> ()) {
        
        if let image = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            completion(image)
            
        } else {
            
            if let url = URL(string: urlString) {
                
                URLSession.shared.dataTask(with: url) {(data, response, error) in
                    
                    if error != nil {
                        return
                        
                    } else {
                        let image = UIImage(data: data!)
                        self.imageCache.setObject(image!, forKey: (urlString as AnyObject))
                        
                        DispatchQueue.main.async(execute: { () -> Void in
                            completion(image!)
                        })
                    }
                }.resume()
                
            } else {
                completion(nil)
            }
        }
    }
}
