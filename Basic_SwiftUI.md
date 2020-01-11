#  Basic SwiftUI

https://developer.apple.com/tutorials/swiftui 를 보면서 만들었습니다.



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

