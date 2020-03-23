//
//  UserData.swift
//  Tutorials
//
//  Created by Gihyun Kim on 2020/01/12.
//  Copyright © 2020 wimes. All rights reserved.
//

import Foundation
import Combine // using ObservalbeObject

//SwiftUI subscribes to your observable object, and updates any views that need refreshing when the data changes.
//This is Observe Pattern in Design Pattern
final class UserData: ObservableObject{
    //An observable object needs to publish any changes to its data, so that its subscribers can pick up the change.
    @Published var showFavoritesOnly = false
    @Published var landmarks = landmarkData
    //사용자가 profileView를 닫아도 데이턴는 지속시키기 위해서 선언
    @Published var profile = Profile.default
}
