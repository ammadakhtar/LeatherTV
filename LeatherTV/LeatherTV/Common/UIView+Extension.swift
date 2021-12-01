//
//  UIView+Extension.swift
//  LeatherTV
//
//  Created by Ammad Akhtar on 30/11/2021.
//

import UIKit

extension UIView {
    
    func createSnapshot() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(frame.size, false, 0.0)
        drawHierarchy(in: frame, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

