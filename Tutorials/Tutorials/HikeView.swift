//
//  HikeView.swift
//  Tutorials
//
//  Created by Gihyun Kim on 2020/03/09.
//  Copyright © 2020 wimes. All rights reserved.
//

import SwiftUI

//새로운 커스텀 애니메이션을 정의 후 리턴
extension AnyTransition{
    static var moveAndFade: AnyTransition{
        let insertion = AnyTransition.move(edge: .trailing)
            .combined(with: .opacity)
        let removal = AnyTransition.scale
            .combined(with: .opacity)
        
        return .asymmetric(insertion: insertion, removal: removal)
    }
}

struct HikeView: View {
    var hike: Hike
    // 토글 할 때 발생하는 모든 변경 사항에 대해 애니메이션을 적용하는 변수
    @State private var showDetail = false
    
    var body: some View {
        VStack {
            HStack {
                HikeGraph(hike: hike, path: \.elevation)
                    .frame(width: 50, height: 30)
                    .animation(nil)
                
                VStack(alignment: .leading) {
                    Text(verbatim: hike.name)
                        .font(.headline)
                    Text(verbatim: hike.distanceText)
                }
                
                Spacer()

                Button(action: {
                    //토글할 때 애니메이션을 적용
                    withAnimation/*(.easeInOut(duration: 4))*/{
                        self.showDetail.toggle()
                    }
                }) {
                    Image(systemName: "chevron.right.circle")
                        .imageScale(.large)
                        .rotationEffect(.degrees(showDetail ? 90 : 0))
//                        .animation(nil)
                        .scaleEffect(showDetail ? 1.5 : 1)
                        .padding()
//                        .animation(.spring())
                }
            }

            if showDetail {
                HikeDetail(hike: hike)
                    //HikeGraph.swift 의 graph 애니메이션 적용
                    .transition(.moveAndFade)
            }
        }
    }
}

struct HikeView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HikeView(hike: hikeData[0])
                .padding()
            Spacer()
        }
    }
}
