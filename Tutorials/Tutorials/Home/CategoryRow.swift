//
//  CategoryRow.swift
//  Tutorials
//
//  Created by Gihyun Kim on 2020/03/19.
//  Copyright © 2020 wimes. All rights reserved.
//

import SwiftUI

// 이 뷰엔는 표시된는 특정 랜드마크 카테고리에 대한 정보와 랜드 마크 자체를 저장해야한다.
struct CategoryRow: View {
    var categoryName: String
    var items: [Landmark]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(self.categoryName)
                .font(.headline)
                .padding(.leading, 15)
                .padding(.top, 5)
            
            //스택을 scrollView로 감싸서 행에 숨을 쉬 공간을 준다.
            //더 많은 데이터 샘플링으로 보면 스크롤 동작이 올바른지 확인할 수 있다.
            ScrollView(.horizontal, showsIndicators: false){
                HStack {
                    ForEach(self.items){ landmark in
                        //CategoryItem 출력, CategoryItem들에게 NavigationLink 달기
                        NavigationLink(
                            destination: LandmarkDetail(
                                landmark: landmark
                            )
                        ) {
                            CategoryItem(landmark: landmark)
                        }
                    }
                }
            }
            //높이 관련 frame(width:height:)을 지정한다.
            .frame(height: 185)
        }
    }
}

//CategoryItem은 각 지역의 이미지와 이름을 표시해주는 View이다.
struct CategoryItem: View {
    var landmark: Landmark
    var body: some View{
        VStack(alignment: .leading){
            landmark.image
                .renderingMode(.original)
                .resizable()
                .frame(width: 155, height: 155)
                .cornerRadius(5)
            Text(landmark.name)
                .foregroundColor(.primary)
                .font(.caption)
        }
        .padding(.leading, 15)
    }
}

struct CategoryRow_Previews: PreviewProvider {
    static var previews: some View {
        CategoryRow(
            categoryName: landmarkData[0].category.rawValue,
            items: Array(landmarkData.prefix(4))
        )
    }
}
