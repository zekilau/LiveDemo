//
//  HomeViewController.swift
//  LiveDemo
//
//  Created by zeki.zequan on 2022/10/10.
//

import UIKit
private let kTitleViewH : CGFloat = 40
class HomeViewController: UIViewController {
    
    
   private lazy var pageTitleView:PageTitleView = {[weak self] in
       
       let titleFrame = CGRect(x:  0, y: CGFloat(KStatusBarHieght+KNavigationBarHeight), width:KScreenWidth , height: kTitleViewH)
       let titles = ["推荐","游戏","娱乐","趣玩"]
       let pageTitleView = PageTitleView.init(frame: titleFrame, titles: titles)
       pageTitleView.delegate = self
       return pageTitleView
   }()
    
    private lazy var pageContoentView :PageContentView = {[weak self] in
        let contentH = KScreenHeight
        let contentFrame = CGRect(x: 0, y:CGFloat(KStatusBarHieght)+CGFloat(KNavigationBarHeight)+CGFloat(kTitleViewH), width: CGFloat(KScreenWidth), height: CGFloat(contentH))
//    自控制器
        var childVcs = [UIViewController]()
        for _ in 0..<4{
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r:CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        let contentView = PageContentView(frame: contentFrame, childsVcs: childVcs, parentViewController: self)
       
        return contentView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any ad ditional setup after loading the view.
    }
    
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
// MARK: 设置UI
extension HomeViewController{
    private func setupUI(){
//        设置导航栏
        setupNavigationBart()
//        pageview
        view.addSubview(pageTitleView)
        view.addSubview(pageContoentView)
    }

    private func setupNavigationBart(){
        let leftBtn = UIButton()
        leftBtn.setImage(UIImage(named: "homeLogoIcon"), for: .normal);
        leftBtn.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
        let size = CGSize(width: 40, height: 40)
        let scranButton = UIBarButtonItem.init(imageName: "cm_nav_search_inner", highImageName: "", size:size )
        let historyButton = UIBarButtonItem.init(imageName: "cm_nav_history_white", highImageName: "", size:size )
        let qrcodeButton = UIBarButtonItem.init(imageName: "cm_nav_richscan", highImageName: "", size:size )
        navigationItem.rightBarButtonItems = [scranButton,historyButton,qrcodeButton]
    }
}
// MARK: titleview协议

extension HomeViewController:PageTitleViewDelegate{
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int) {
        pageContoentView.setCurrentIndex(currentIndex: index)
    }
}
