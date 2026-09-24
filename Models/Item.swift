//
//  Item.swift
//  OnBoarding
//
//  Created by Indexer on 9/23/26.
//
import SwiftUI
struct Item :Identifiable{
    var id :Int
    var title :String
    var subTitle:String
    var snapshot:UIImage?
    var zoomScale:CGFloat = 1
    var zoomAnchor:UnitPoint = .center
    
}
