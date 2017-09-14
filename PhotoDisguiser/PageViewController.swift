//
//  PageViewController.swift
//  PhotoDisguiser
//
//  Created by Kyoya Yamaguchi on 2017/02/26.
//  Copyright © 2017年 Kyoya Yamaguchi. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setViewControllers([getSecond()], direction: .forward, animated: true, completion: nil)
        self.dataSource = self
        
    }
    
    //    func getFirst() -> FirstViewController {
    //        return storyboard!.instantiateViewController(withIdentifier: "FirstViewController") as!FirstViewController
    //    }
    func getSecond() -> SecondViewController {
        return storyboard!.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
    }
    func getThird() -> ThirdViewController{
        return storyboard!.instantiateViewController(withIdentifier: "ThirdViewController") as!ThirdViewController
    }
    func getFourth() -> FourthViewController {
        return storyboard!.instantiateViewController(withIdentifier: "FourthViewController") as! FourthViewController
    }
    func getFifth() -> FifthViewController {
        return storyboard!.instantiateViewController(withIdentifier: "FifthViewController") as!FifthViewController
    }
    func getsixth() -> SixthViewController {
        return storyboard!.instantiateViewController(withIdentifier: "SixthViewController") as!SixthViewController
    }
    func getSeventh() -> SeventhViewController {
        return storyboard!.instantiateViewController(withIdentifier: "SeventhViewController") as!SeventhViewController
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
extension PageViewController : UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        //        if viewController.isKind(of: SecondViewController.self) {
        //            return getFirst()
        //        }else
        if viewController.isKind(of: ThirdViewController.self) {
            return getSecond()
        }else if viewController.isKind(of: FourthViewController.self) {
            return getThird()
        }else if viewController.isKind(of: FifthViewController.self) {
            return getFourth()
        }else if viewController.isKind(of: SixthViewController.self) {
            return getFifth()
        }else if viewController.isKind(of: SeventhViewController.self) {
            return getsixth()
        }else{
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        //        if viewController.isKind(of: FirstViewController.self) {
        //            return getSecond()
        //        } else
        if viewController.isKind(of: SecondViewController.self) {
            return getThird()
        } else if viewController.isKind(of: ThirdViewController.self){
            return getFourth()
        } else if viewController.isKind(of: FourthViewController.self){
            return getFifth()
        } else if viewController.isKind(of: FifthViewController.self){
            return getsixth()
        } else if viewController.isKind(of: SixthViewController.self){
            return getSeventh()
        }else{
            return nil
        }
    }
}
