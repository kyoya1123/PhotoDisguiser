import UIKit

class PageViewController: UIPageViewController {
    
    let idList = ["Second","Third","Fourth","Fifth","Sixth","Seventh"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let firstPage = idList.first else { return }
        guard let controller = storyboard?.instantiateViewController(withIdentifier: firstPage) else { return }
        setViewControllers([controller], direction: .forward, animated: true, completion:nil)
        dataSource = self
    }
}

extension PageViewController : UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let restorationId = viewController.restorationIdentifier else { return nil }
        guard let index = idList.index(of: restorationId) else { return nil }
        if index > 0 {
            return storyboard?.instantiateViewController(withIdentifier: idList[index - 1])
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let restorationId = viewController.restorationIdentifier else { return nil }
        guard let index = idList.index(of: restorationId) else { return nil }
        if index < idList.count - 1 {
            return storyboard?.instantiateViewController(withIdentifier: idList[index + 1])
        }
        return nil
    }
}
