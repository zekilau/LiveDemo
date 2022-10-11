//
//  UIBarButtonItem_Extention.swift
//  LiveDemo
//
//  Created by zeki.zequan on 2022/10/10.
//

import UIKit

extension UIBarButtonItem{
    convenience init(imageName:String="" ,highImageName:String="",size:CGSize=CGSize.zero) {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal);
        btn.setImage(UIImage(named: highImageName), for: .highlighted)
        if size == CGSize.zero{
            btn.sizeToFit()
        }else{
            btn.frame = CGRect(origin: CGPoint(), size: size);
        }
        self.init(customView:btn)
    }
}
