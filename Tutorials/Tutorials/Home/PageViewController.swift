//
//  PageViewController.swift
//  Tutorials
//
//  Created by Gihyun Kim on 2020/03/29.
//  Copyright © 2020 wimes. All rights reserved.
//

import SwiftUI
import UIKit

//
struct PageViewController: UIViewControllerRepresentable {
    // landmark를 스크롤하기 위한 page
    var controllers: [UIViewController]
    @Binding var currentPage: Int
    
    // makeUIViewController(context:)를 호출하기전에 makeCoordinator를 호출하기 때문에 viewController를 구성할 때 코디네이터(coordinator)객체에 엑세스 할 수 있다.
    // 이 coordinator를 사용하여 delegate, datasource 를 통한 사용자 이벤트 응답과 같은 일반적인 cocoparrent을 구현할 수 있다.
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    // UIPageViewController를 만드는 메서드
    // SwiftUI는 view를 표시할 준비가 되면 이 메서드를 한 번 호출한 다음 viewcontroller의 수명주기를 관리한다.
    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageViewController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal
        )
        // UIPageViewController의 dataSource 로 coordinator를 넣는다.
        pageViewController.dataSource = context.coordinator
        
        // UIPAgeViewController의 delegate 를 coordinator로 지정
        // 바인딩을 양방향으로 연결하면 TextView가 업데이트되어 각 스와이프 후 올바른 페이지가 표시된다.
        pageViewController.delegate = context.coordinator
        
        return pageViewController
    }
    
    func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
        //setControllerss를 호출하여 배열의 첫번째 controller를 표시
        pageViewController.setViewControllers(
            [controllers[self.currentPage]],
            direction: .forward,
            animated: true
        )
    }
    
    //PageView를 통해 Page를 Swipe했을 때 값이 변경되는 것을 구현하기 위해 UIPageViewControllerDelegate를 채택한다.
    class Coordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate{
        var parent: PageViewController
        
        init(_ pageViewController: PageViewController) {
            self.parent = pageViewController
        }
        
        // UIPageViewControllerDataSource를 채택함에 따라 메서드들을 구현한다.
        // 밑의 두 메서드는 viewController간의 관계를 설정하여 스와이프 하여 화면을 전환할 수 있다.
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            guard let index = parent.controllers.firstIndex(of: viewController) else {
                return nil
            }
            
            if index == 0{
                return parent.controllers.last
            }
            
            return parent.controllers[index - 1]
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let index = parent.controllers.firstIndex(of: viewController) else {
                return nil
            }
            
            if index + 1 == parent.controllers.count{
                return parent.controllers.first
            }
            
            return parent.controllers[index + 1]
        }
        
        // UIPageViewControllerDelegate를 채택함에 따라 아래의 메서드를 구현한다.
        // SwiftUI는 페이지 전환 애니메이션이 완료될 때 마다 이 메서드를 호출하기 때문에 현재 ViewController의 색인을 찾아 바인딩을 업데이트 할 수 있다.
        func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
            if completed,
                let visibleViewController = pageViewController.viewControllers?.first,
                let index = parent.controllers.firstIndex(of: visibleViewController)
            {
                parent.currentPage = index
            }
        }
    }
    
    
    
}
