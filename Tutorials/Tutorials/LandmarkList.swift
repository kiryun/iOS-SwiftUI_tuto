//
//  LandmarkList.swift
//  Tutorials
//
//  Created by Gihyun Kim on 2020/01/11.
//  Copyright © 2020 wimes. All rights reserved.
//

import SwiftUI

struct LandmarkList: View {
    @EnvironmentObject var userData: UserData
//    @State var showFavoriteOnly = true
    
    var body: some View {
        NavigationView{
            List{
                Toggle(isOn: $userData.showFavoritesOnly){
                    Text("Favorites only")
                }

                ForEach(userData.landmarks) { landmark in
                    if !self.userData.showFavoritesOnly || landmark.isFavorite {
                        NavigationLink(destination: LandmarkDetail(landmark: landmark)){
                            LandmarkRow(landmark: landmark)
                        }
                    }
                    
                }
            }
            
        }
    .navigationBarTitle(Text("Landmarks"))
        
    }
}

struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {
//        ForEach(["iPhone SE", "iPhone XS Max"], id: \.self){ deviceName in
//            LandmarkList()
//            .previewDevice(PreviewDevice(rawValue: deviceName))
//
//        }
        LandmarkList()
        .environmentObject(UserData())
    }
}
