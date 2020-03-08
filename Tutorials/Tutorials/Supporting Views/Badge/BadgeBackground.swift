//
//  BadgeBackground.swift
//  Tutorials
//
//  Created by Gihyun Kim on 2020/03/08.
//  Copyright © 2020 wimes. All rights reserved.
//

import SwiftUI

struct BadgeBackground: View {
    static let gradientStart = Color(red: 239.0 / 255, green: 120.0 / 255, blue: 221.0 / 255)
    static let gradientEnd = Color(red: 239.0 / 255, green: 172.0 / 255, blue: 120.0 / 255)
    
    var body: some View {
        //Path를 GeometryReader로 감싸서 width를 100으로 하드코딩하는 대신 Badge가 부모뷰의 사이즈를 사용할 수 있게 한다.
        GeometryReader { geometry in
            // paths를 사용하여 선, 곡선 및 기타 드로잉 프리미티브를 결합하여 뱃지의 육각형 배경과 같이 더 복잡한 모양을 형성한다.
            Path{ path in
                //move를 이용해 그린다.
                var width: CGFloat = min(geometry.size.width, geometry.size.height)
                let height = width
                let xScale: CGFloat = 0.832
                let xOffset = (width * (1.0 - xScale)) / 2.0
                width *= xScale
                path.move(to: CGPoint(x: xOffset + width * 0.95,
                                      y: height * (0.20 + HexagonParameters.adjustment))
                )
                
                //모양 데이터의 각 점에 대한 선을 그려 대략 6각형 모양을 만든다.
                HexagonParameters.points.forEach {
                    // addLine은 단일 포인트를 가져와서 그린다.
                    // addLine(to:)에 대한 연속적인 호출은 이전 지점에서 라인을 시작하고 새 지점으로 계속한다.
                    path.addLine(
                        to: .init(x: xOffset + width * $0.xFactors.0,
                                  y: height * $0.yFactors.0
                        )
                    )
                    
                    path.addQuadCurve(to: .init(x: xOffset + width * $0.useWidth.1 * $0.xFactors.1,
                                                y: height * $0.useHeight.1 * $0.yFactors.1),
                                      control: .init(x: xOffset + width * $0.useWidth.2 * $0.xFactors.2,
                                                     y: height * $0.useHeight.2 * $0.yFactors.2)
                    )
                }
            }
            // 컬러변경(그라데이션으로)
            .fill(LinearGradient(
                gradient: .init(colors: [Self.gradientStart, Self.gradientEnd]),
                startPoint: .init(x: 0.5, y: 0),
                endPoint: .init(x: 0.5, y: 0.6)
            ))
            //aspectRatio를 gradient에 적용한다.
            //1:1 종횡비를 유지하면 Badge의 부모뷰가 정사각형이 아닌경우에도 Badge가 뷰의 중앙에 위치함
                .aspectRatio(1, contentMode: .fit)
        }
    }
}

struct BadgeBackground_Previews: PreviewProvider {
    static var previews: some View {
        BadgeBackground()
    }
}
