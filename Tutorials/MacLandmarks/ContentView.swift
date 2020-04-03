//
//  ContentView.swift
//  MacLandmarks
//
//  Created by Gihyun Kim on 2020/04/03.
//  Copyright © 2020 wimes. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedLandmark: Landmark?
    
    var body: some View {
        NavigationView {
            NavigationMaster(selectedLandmark: $selectedLandmark)
            
            if selectedLandmark != nil{
                NavigationDetail(landmark: selectedLandmark!)
            }
                
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        .environmentObject(UserData())
    }
}
