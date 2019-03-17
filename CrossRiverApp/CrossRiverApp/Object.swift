//
//  Object.swift
//  FlappyBird
//
//  Created by 杜李 on 2019/1/12.
//

import UIKit
class Object {
    var name: String
    var num: Int
    var load: Int
    var master: String
    var predator: String
    var naturalenemy: String
    var competitor: String
    var boating: Bool
    var cross: Bool
    
    init?(name: String, num: Int, load: Int,master: String,predator:String,naturalenemy:String,competitor:String,boating:Bool,cross:Bool){
        self.name = name
        self.num = num
        self.load = load
        self.master = master
        self.predator = predator
        self.naturalenemy = naturalenemy
        self.competitor = competitor
        self.boating = boating
        self.cross = cross
    }
    

}
