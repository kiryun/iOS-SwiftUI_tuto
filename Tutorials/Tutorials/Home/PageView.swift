//
//  PageView.swift
//  Tutorials
//
//  Created by Gihyun Kim on 2020/03/29.
//  Copyright © 2020 wimes. All rights reserved.
//

import SwiftUI

//UIViewControllerRepresentable 를 출력해줄 View
struct PageView<Page: View>: View {
    var viewControllers: [UIHostingController<Page>]
    @State var currentPage = 0
    
    //viewController에 views배열 각각의 요소를 UIHostringController로 ViewController로 변환
    init( _ views: [Page]){
        self.viewControllers = views.map{ UIHostingController(rootView: $0) }
    }
    
    var body: some View{
        ZStack(alignment: .bottomTrailing) {
            PageViewController(controllers: viewControllers, currentPage: self.$currentPage)
            PageControl(numberOfPages: viewControllers.count, currentPage: $currentPage)
                .padding(.trailing)
        }
    }
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        //Models/Data.featrues
        //SupportingViews/FeatureCard
        PageView(features.map{ FeatureCard(landmark: $0)})
            .aspectRatio(3/2, contentMode: .fit)
    }
}
