//
//  ProfileHost.swift
//  Tutorials
//
//  Created by Gihyun Kim on 2020/03/22.
//  Copyright © 2020 wimes. All rights reserved.
//

import SwiftUI

//Profile의 완성 뷰
struct ProfileHost: View {
    @Environment(\.editMode) var mode
    @EnvironmentObject var userData: UserData
    @State var draftProfile = Profile.default
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack{
                
                if self.mode?.wrappedValue == .active{
                    //cancel 버튼을 눌렀을 경우 편집한 내용이 적용되지 않도록 한다.
                    Button("Cancel"){
                        //이전 profile 내용을 다시 현재의 profile내용으로 덮어씌운다.
                        self.draftProfile = self.userData.profile
                        self.mode?.animation().wrappedValue = .inactive
                    }
                }
                
                Spacer()
                
                EditButton()
            }
            
            //editmode와 일반 모드를 분리해서 View를 호출하도록 한다.
            if self.mode?.wrappedValue == .inactive{
                ProfileSummary(profile: userData.profile)
            }else{
                ProfileEditor(profile: $draftProfile)
                    //onAppear 됐을 때랑 disappear 됐을 때 profile 데이터가 어떻게 들어가는지 정의
                    .onAppear(){
                        self.draftProfile = self.userData.profile
                    }
                    .onDisappear(){
                        self.userData.profile = self.draftProfile
                    }
            }
//            ProfileSummary(profile: draftProfile)
        }
    .padding()
    }
}

struct ProfileHost_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHost()
        .environmentObject(UserData())
    }
}
