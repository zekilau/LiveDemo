//
//  PageContentView.swift
//  LiveDemo
//
//  Created by zeki.zequan on 2022/10/10.
//

import UIKit
private let collectId = "collectionId"
class PageContentView: UIView {
//    MARK: 定义属性
    private var childs:[UIViewController]
    private weak var parentVC :UIViewController?
//     MARK: 懒加载属性
    private lazy var collectionView: UICollectionView = {[weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
//        创建view
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: collectId)
        collectionView.delegate = self
        return collectionView
    }()
    init(frame: CGRect,childsVcs:[UIViewController], parentViewController:UIViewController?) {
        self.childs = childsVcs
        self.parentVC = parentViewController
        super.init(frame:frame)
        
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


// MARK: 设置界面
extension PageContentView{
    private func setUpUI(){
//        添加到父容器
        for childVc in childs{
            parentVC?.addChild(childVc)
        }
        
        addSubview(collectionView)
        collectionView.frame = bounds
        
    }
}
// MARK: 数据源
extension PageContentView:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childs.count
    }
    
  
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectId, for: indexPath)
        
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let childVc = childs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        return cell
    }
}

// MARK: collection delegate
extension PageContentView:UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
    }
}
// MARK: 对外暴露方法
extension PageContentView{
    func setCurrentIndex(currentIndex:Int){
        let offsetX = CGFloat(currentIndex)*collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}
