//
//  Extensions.swift
//  Spoti
//
//  Created by Anıl Bürcü on 11.09.2023.
//

import Foundation
import UIKit


extension UIView {
        
        var width:CGFloat {
            return frame.size.width
        }
        
        var height:CGFloat {
            return frame.size.height
        }
        
        var left:CGFloat {
            return frame.origin.x
        }
        
        var right:CGFloat {
            return left + width
        }
        
        var top:CGFloat {
            return frame.origin.y
        }
        
        var bottom:CGFloat {
            return top + height
        }
    }

extension Notification.Name {
    static let albumSavedNotification = Notification.Name("albumSavedNotification")
}
