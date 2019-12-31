//
//  ImageExtension.swift
//  iJob
//
//  Created by Vinoth Varatharajan on 03/03/18.
//  Copyright © 2018 Vin. All rights reserved.
//

import UIKit

extension UIImage {
    func fixOrientation() -> UIImage {
        if self.imageOrientation == UIImage.Orientation.up {
            return self
        }
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        self.draw(in: CGRect(x:0, y:0, width:self.size.width, height:self.size.height))
        let normalizedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return normalizedImage;
    }
}
