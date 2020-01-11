#  Basic SwiftUI

[여기](https://developer.apple.com/tutorials/swiftui)와 [여기](https://zetal.tistory.com/entry/SwiftUI-Tutorials-10-Mark-the-User's-Favorite-Landmarks)에서 공부하면서 정리한 내용입니다.

## View attach(?)방법

아래와 같이 구현된 LandmarkRow.swift 가 있습니다.

LandmarkRow의 property로는 landmark가 있습니다.

**LandmarkRow.swift**

```swift
import SwiftUI

struct LandmarkRow: View{
  var landmark: Landmark
//  var testInstance: LandmarkData
  
  // ...
}
```

이 LandmarkRow를 다른 View에서 사용하고자 한다면 `LandmarkRow(landmark: Landmark)` 형태로 사용되어져야만 합니다.

아래의 코드를 보시면 이해가 되실겁니다.

**LandmarkList.swift**

```swift
import SwiftUI

struct LandmarkList: View{
  var body: some View{
    LandmarkRow() // error
  }
}
```

위의 코드처럼 파라미터 없이 LandmarkRow View를 호출한다면 error가 출력될 것입니다.

![image-20200111231539216](/Users/gihyunkim/Library/Application Support/typora-user-images/image-20200111231539216.png)

이를 위해서는 LandmarkRow에 선언된 property 형식에 맞는 파라미터를 넘겨줘야 합니다.

**LandmarkList.swift**

```swift
import SwiftUI

struct LandmarkList: View{
  var body: some View{
    // ...
    LandmarkRow(landmark: landmark) // landmark type: Landmark
  }
}
```



## @State

**Test.swift**

```swift
import SwiftUI

struct TestView: View{
  var temp = 0
  
  var body: some View{
  	self.temp +=1 // error  
    // ...
  }
}
```

위의 코드에서 temp를 변경하면 error를 출력합니다.
구조체의 특징상 **내부 메서드 안에서 자신의 변수를 변경할 수 없기 때문**입니다.

Swift 5.1에서는 이런 문제를 해결하기 위해 State 키워드가 만들어졌습니다.

`@State var temp = 0`

touchedCount 변수에 State 어노테이션을 선언해주면 정상적으로 실행할 수 있습니다. SwiftUI에서는 **State 어노테이션(@)이 붙은 변수에 변경이 일어나면 자동으로 View를 다시 렌더링**하게됩니다.



## Swift에서의 Observer, @Published, @EnvironmentObject

[참고](https://www.hackingwithswift.com/quick-start/swiftui/observable-objects-environment-objects-and-published)

### ObservableObject / @Published

* ObservableObject
  Swift내에서의 Observer(구독/알림 기능)Pattern을 구현하려면 ObservableObject protocol을 채택하면 됩니다.
  이제 SwiftUI는 특정 데이터가 변경될 때 새로 고쳐야하는 모든 뷰를 업데이트합니다.

* @Published
  ObservableObject 객체는 구독자가 변경사항을 알 수 있도록 데이터에 대한 변경사항도 나타낼 수 있어야 합니다.

**UserData.swift**

```swift
import Foundation
import Combine // using ObservalbeObject

//SwiftUI subscribes to your observable object, and updates any views that need refreshing when the data changes.
//This is Observe Pattern in Design Pattern
final class UserData: ObservableObject{
    //An observable object needs to publish any changes to its data, so that its subscribers can pick up the change.
    @Published var showFavoritesOnly = false
    @Published var landmarks = landmarkData
}
```

### @EnvironmentObject

**LandmarkList.swift**

```swift
import SwiftUI
struct LandmarkList: View {
  @EnvironmentObject var userData: UserData 
  var body: some View { 
    // ...
  } 
} 
struct LandmarkList_Previews: PreviewProvider { 
  static var previews: some View { 
    LandmarkList() 
    .environmentObject(UserData()) 
  } 
}
```

LandmarkList_Previews 구조체의 LandmarkList()에 `environmentObject(_:)` 수정자를 preview에 추가 했습니다.
`environmentObject(_:)`수정자가 부모에 적용되는 동안 userData프로퍼티는 해당 값( UserData() )을 자동으로 가져옵니다.

`@EnvironmentObject`와 `.environmentObject(UserData())`가 서로 연결되어있다고 생각하면 편합니다.
이로서 LandmarkList에서 `userData.*`로 되어있는 것들은 userData의 @Published가 변경될 때 마다 해당 View(LandmarkList)를 업데이트합니다.

아래의 예제를 보면 더 쉽게 이해가 가실겁니다.

**LandmarkDetial.swift**

```swift
import SwiftUI

struct LandmarkDetail: View {
  @EnvironmentObject var userData: UserData
	var landmark: Landmark
  var landmarkIndex: Int {
    //userData.landmarks에서 userData.id와 landmark.id가 같은 값들 중에서 첫번째 인덱스를 리턴
    userData.landmarks.firstIndex(where: { $0.id == landmark.id })! 
  }

```

랜드 마크의 즐겨 찾기 상태에 액세스하거나 업데이트 할 때 landmarkIndex를 사용하여 항상 해당 데이터의 올바른 버전(**userData가 다른 View에서 변화 될 때 동기화**)에 액세스 할 수 있습니다.

**SceneDelegate.swift**

```swift
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`. 
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene. 
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead). 
    // Use a UIHostingController as window root view controller 
    if let windowScene = scene as? UIWindowScene {
      let window = UIWindow(windowScene: windowScene)
      window.rootViewController = UIHostingController( 
        rootView: LandmarkList()
        .environmentObject(UserData()) // 이부분
      )
      self.window = window window.makeKeyAndVisible() 
    } 
  } 
    // ... 
}

```

위의 SceneDelegate.swift는 미리보기를 사용하지 않고 시뮬레이터 또는 디바이스에서 랜드 마크를 빌드하고 실행하는 경우 이것은 LandmarkList가 UserData 오브젝트를 갖도록합니다.

이 예제를 실행시키면 목록에서 세부 사항으로 이동하고 버튼을 누르면 목록으로 돌아갈 때 변경 사항이 유지됩니다. 
두 뷰가 환경에서 동일한 모델 객체에 액세스하기 때문에 두 뷰는 일관성을 유지합니다.

[예제코드]()