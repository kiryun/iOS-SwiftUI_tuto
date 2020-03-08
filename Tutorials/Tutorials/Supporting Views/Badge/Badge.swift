//
//  Badge.swift
//  Tutorials
//
//  Created by Gihyun Kim on 2020/03/08.
//  Copyright © 2020 wimes. All rights reserved.
//

import SwiftUI



struct Badge: View {
    static let rotationCount = 8 // 8번 돌아간다.
    
    //badgesymbol의 각방향대로 돌려서 뿌려줌
    var badgeSymbols: some View{
        ForEach(0 ..< Badge.rotationCount){ i in
            RotatedBadgeSymbol(angle: .init(degrees: Double(i) / Double(Badge.rotationCount)) * 360.0)
        }
        .opacity(0.5)
    }
    
    //badge와 관련된 것들을 합쳐서 뿌려줌
    var body: some View {
        ZStack{
            BadgeBackground()
            
            GeometryReader{ geometry in
                self.badgeSymbols
                .scaleEffect(1.0 / 4.0, anchor: .top)
                    .position(x: geometry.size.width / 2.0, y: (3.0/4.0) * geometry.size.height)
            }
        }
        .scaledToFit()
    }
}

struct Badge_Previews: PreviewProvider {
    static var previews: some View {
        Badge()
    }
}
