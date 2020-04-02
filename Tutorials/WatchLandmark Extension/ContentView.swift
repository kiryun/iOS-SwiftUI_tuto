//
//  ContentView.swift
//  WatchLandmark Extension
//
//  Created by Gihyun Kim on 2020/04/02.
//  Copyright © 2020 wimes. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        LandmarkList { WatchLandmarkDetail(landmark: $0) }
        .environmentObject(UserData())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkList { WatchLandmarkDetail(landmark: $0) }
        .environmentObject(UserData())
    }
}
