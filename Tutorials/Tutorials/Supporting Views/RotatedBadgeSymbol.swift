//
//  RotatedBadgeSymbol.swift
//  Tutorials
//
//  Created by Gihyun Kim on 2020/03/08.
//  Copyright © 2020 wimes. All rights reserved.
//

import SwiftUI

// badgesymbol을 회전시켜서 문양 만들어 줌
struct RotatedBadgeSymbol: View {
    let angle: Angle
    
    var body: some View {
        BadgeSymbol()
            .padding(-60)
            .rotationEffect(angle, anchor: .bottom)
    }
}

struct RotatedBadgeSymbol_Previews: PreviewProvider {
    static var previews: some View {
        RotatedBadgeSymbol(angle: .init(degrees: 5))
    }
}
