//
//  NavigationMaster.swift
//  MacLandmarks
//
//  Created by Gihyun Kim on 2020/04/03.
//  Copyright © 2020 wimes. All rights reserved.
//

import SwiftUI

struct NavigationMaster: View {
    @Binding var selectedLandmark: Landmark?
    @State private var filter: FilterType = .all
    
    var body: some View {
        VStack {
            Filter(filter: $filter)
                .controlSize(.small)
                .padding([.top, .leading], 8)
                .padding(.trailing, 4)
            
            LandmarkList(selectedLandmark: $selectedLandmark, filter: $filter)
            .listStyle(SidebarListStyle())
        }
        .frame(minWidth: 255, maxWidth: 300)
    }
}

struct NavigationMaster_Previews: PreviewProvider {
    static var previews: some View {
        NavigationMaster(selectedLandmark: .constant(landmarkData[1]))
        .environmentObject(UserData())
    }
}
