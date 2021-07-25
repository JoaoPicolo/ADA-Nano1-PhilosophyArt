//
//  Scene.swift
//  NanoCrash1
//
//  Created by João Pedro Picolo on 21/07/21.
//

import Foundation
import UIKit

struct Option: Hashable, Codable {
    var description: String
    var nextScene: Int
    var penalty: Int
    
    var imageName: String
    var image: UIImage {
        UIImage(named: imageName)!
    }
}

struct Scene: Codable, Hashable, Identifiable {
    var id: Int
    var description: String
    var options: [Option]
}
