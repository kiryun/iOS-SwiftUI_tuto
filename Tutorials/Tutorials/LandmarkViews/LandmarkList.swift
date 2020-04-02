//
//  LandmarkList.swift
//  Tutorials
//
//  Created by Gihyun Kim on 2020/01/11.
//  Copyright © 2020 wimes. All rights reserved.
//

import SwiftUI

struct LandmarkList<DetailView: View>: View {
    @EnvironmentObject var userData: UserData
//    @State var showFavoriteOnly = true
    
    let detailViewProducer: (Landmark) -> DetailView
    
    var body: some View {
        List{
            Toggle(isOn: $userData.showFavoritesOnly){
                Text("Favorites only")
            }

            ForEach(userData.landmarks) { landmark in
                if !self.userData.showFavoritesOnly || landmark.isFavorite {
                    NavigationLink(destination: self.detailViewProducer(landmark).environmentObject(self.userData)){
                        LandmarkRow(landmark: landmark)
                    }
                }
                
            }
        }
        .navigationBarTitle(Text("Landmarks"))
        
    }
}

#if os(watchOS)
typealias PreviewDetailView = WatchLandmarkDetail
#else
typealias PreviewDetailView = LandmarkDetail
#endif

struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {
//        ForEach(["iPhone SE", "iPhone XS Max"], id: \.self){ deviceName in
//            LandmarkList()
//            .previewDevice(PreviewDevice(rawValue: deviceName))
//
//        }
        
        LandmarkList{
            PreviewDetailView(landmark: $0)
        }
        .environmentObject(UserData())
        
        
    }
}
