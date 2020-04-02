//
//  Home.swift
//  Tutorials
//
//  Created by Gihyun Kim on 2020/03/19.
//  Copyright © 2020 wimes. All rights reserved.
//

import SwiftUI

struct CategoryHome: View {
    //Dictionary(grouping:by:)를 사용해서 랜드 마크를 카테고리로 그룹화한다.
    var categories: [String: [Landmark]]{
        Dictionary(
            grouping: landmarkData, by: { $0.category.rawValue }
        )
    }
    
    var featured: [Landmark]{
        landmarkData.filter { $0.isFeatured }
    }
    
    @State var showingProfile = false
    @EnvironmentObject var userData: UserData
    
    //profileButton을 누르면 showingProfile이 변경됨
    var profileButton: some View{
        Button(action: { self.showingProfile.toggle()}){
            Image(systemName: "person.crop.circle")
                .imageScale(.large)
            .accessibility(label: Text("User Profile"))
            .padding()
        }
    }
    
    var body: some View{
        NavigationView{
            List {
                
                FeaturedLandmarks(landmarks: featured)
                    .scaledToFill()
                    .frame(height: 200)
                    .clipped()
                    .listRowInsets(EdgeInsets())
                
                ForEach(categories.keys.sorted(), id: \.self){ key in
                    // category 정보를 새로운 row type으로 전달한다.
                    CategoryRow(categoryName: key,
                                items: self.categories[key]!)
                }
                //Feature의 가장자리의 공백을 0으로 만든다.
                .listRowInsets(EdgeInsets())
                
                NavigationLink(destination: LandmarkList{ LandmarkDetail(landmark: $0) }){
                    Text("See All")
                }
            }
            .navigationBarTitle(Text("Featrued"))
            .navigationBarItems(trailing: profileButton)
            .sheet(isPresented: $showingProfile) {
                ProfileHost()
                    .environmentObject(self.userData)
            }
        }
    }
}

//Landmark의 Feature를 표출해주는 View
struct FeaturedLandmarks: View {
    var landmarks: [Landmark]
    var body: some View{
        landmarks[0].image.resizable()
    }
}

struct CategoryHome_Previews: PreviewProvider {
    static var previews: some View{
        CategoryHome()
    }
}
