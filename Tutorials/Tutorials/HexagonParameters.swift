//
//  HexagonParameters.swift
//  Tutorials
//
//  Created by Gihyun Kim on 2020/03/08.
//  Copyright © 2020 wimes. All rights reserved.
//

import SwiftUI

//육각형 모양을 그리기위한 세부사항을 정의한다.
//이 data는 수정하지 않는다.
//대신 이 data를 사용하여 배지의 선과 곡선을 그리기위한 control points를 지정한다.
struct HexagonParameters {
    struct Segment {
        let useWidth: (CGFloat, CGFloat, CGFloat)
        let xFactors: (CGFloat, CGFloat, CGFloat)
        let useHeight: (CGFloat, CGFloat, CGFloat)
        let yFactors: (CGFloat, CGFloat, CGFloat)
    }
    static let adjustment: CGFloat = 0.085
    static let points = [ Segment( useWidth: (1.00, 1.00, 1.00),
                                   xFactors: (0.60, 0.40, 0.50),
                                   useHeight: (1.00, 1.00, 0.00),
                                   yFactors: (0.05, 0.05, 0.00) ),
                          Segment( useWidth: (1.00, 1.00, 0.00),
                                   xFactors: (0.05, 0.00, 0.00),
                                   useHeight: (1.00, 1.00, 1.00),
                                   yFactors: (0.20 + adjustment, 0.30 + adjustment, 0.25 + adjustment) ),
                          
                          Segment( useWidth: (1.00, 1.00, 0.00),
                                   xFactors: (0.00, 0.05, 0.00),
                                   useHeight: (1.00, 1.00, 1.00),
                                   yFactors: (0.70 - adjustment, 0.80 - adjustment, 0.75 - adjustment) ),
                          
                          Segment( useWidth: (1.00, 1.00, 1.00),
                                   xFactors: (0.40, 0.60, 0.50),
                                   useHeight: (1.00, 1.00, 1.00),
                                   yFactors: (0.95, 0.95, 1.00) ),
                          Segment( useWidth: (1.00, 1.00, 1.00),
                                   xFactors: (0.95, 1.00, 1.00),
                                   useHeight: (1.00, 1.00, 1.00),
                                   yFactors: (0.80 - adjustment, 0.70 - adjustment, 0.75 - adjustment) ),
                          Segment( useWidth: (1.00, 1.00, 1.00),
                                   xFactors: (1.00, 0.95, 1.00),
                                   useHeight: (1.00, 1.00, 1.00),
                                   yFactors: (0.30 + adjustment, 0.20 + adjustment, 0.25 + adjustment) )
    ]
}

