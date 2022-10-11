//
//  PageTitleView.swift
//  LiveDemo
//
//  Created by zeki.zequan on 2022/10/10.
//

import UIKit

protocol PageTitleViewDelegate: AnyObject  {
    func pageTitleView(titleView:PageTitleView, selectedIndex index: Int)
}

private let kScrollLineHeight = 2
class PageTitleView: UIView {
    private var currentIndex = 0
    weak var delegate: PageTitleViewDelegate?
    private lazy var titleLabels:[UILabel] = []
    private var titles:[String]
    private lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false;
        scrollView.scrollsToTop = false;
        scrollView.showsHorizontalScrollIndicator = false;
        return scrollView
    }()
    
    private lazy var scrollLine:UIView={
        let line = UIView()
        line.backgroundColor = UIColor.orange
        return line
    }()
    
    init(frame:CGRect, titles:[String]) {
        self.titles = titles
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension PageTitleView{
    private func setUpUI(){
        addSubview(scrollView)
        scrollView.frame = bounds
        titleViews()
        bottomLine()
    }
    
    private func titleViews(){
        
        for (index,title) in titles.enumerated() {
            
            let frame = CGRect(x: frame.width/CGFloat(titles.count) * CGFloat(index), y: 0, width: frame.width/CGFloat(titles.count), height:frame.height-CGFloat(kScrollLineHeight) )
            
            let lable = UILabel(frame: frame)
            lable.tag = index
            lable.text = title
            lable.textAlignment = NSTextAlignment.center
            lable.textColor = UIColor.darkGray
            titleLabels.append(lable)
            scrollView.addSubview(lable)
            
//            给label添加手势
            lable.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action:#selector(self.titleLabelClick(tapGes:)))
            lable.addGestureRecognizer(tapGes)
        }
    }
    
    private func bottomLine(){
        let lineH = 0.5
        let bottomLine = UIView(frame: CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH))
        bottomLine.backgroundColor = UIColor.lightGray
        addSubview(bottomLine)
        guard let firstLabel = titleLabels.first else{return}
        scrollView.addSubview(scrollLine)
        scrollLine.frame  = CGRect(x: firstLabel.frame.origin.x, y: frame.height-CGFloat(kScrollLineHeight), width: firstLabel.frame.width, height: CGFloat(kScrollLineHeight))
        scrollView.addSubview(scrollLine)
    }
}


extension PageTitleView{
    @objc private func  titleLabelClick(tapGes:UITapGestureRecognizer){
//       获取当前label
       guard let currentLabel = tapGes.view as? UILabel else {return}
        let oldLabel = titleLabels[currentIndex]
        currentIndex = currentLabel.tag
        
        currentLabel.textColor = UIColor.orange
        oldLabel.textColor = UIColor.darkGray
        
        // 滚动条位置改变
        let scrollPosition = CGFloat(currentLabel.tag)*scrollLine.frame.width
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollPosition
        }
//        通知代理
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
    }
}
