//
//  WBMainViewController.swift
//  WB_BCH
//
//  Created by 白成慧&瑞瑞 on 16/10/2.
//  Copyright © 2016年 bch. All rights reserved.
//

import UIKit

class WBMainViewController: UITabBarController {

    // MARK: – Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setUpChildViewControllers()
   
        setUpComposeButton()
        
        
    }
    
    
    /**
        使用代码控制设备的方向,好处,可以在需要横屏的时候,单独处理
        设置支持的方向之后,当前的控制器及子控制器会遵守这个方向
        如果视频播放,通常是通过 modal 展现的
     */
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return .portrait
    }
    
    private lazy var composeButton : UIButton = UIButton.bch_buttonWithImage(imageName: "tabbar_compose_icon_add", backgroundImage: "tabbar_compose_button")
    
    
    // MARK: - Events
    
    // FIXME: 没有实现
    //private 能够保证方法私有,仅在当前对象呗访问
    //@objc 允许这个函数在 '运行时' 通过 OC 的消息机制被调用
    @objc private func composeStatusClick() {
        print("撰写微博")
        
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.cyan
        let nav = UINavigationController(rootViewController: vc)
        
        present(nav, animated: true, completion: nil)
    }
    
    
    // MARK: – Private Methods
    
    private func setUpComposeButton() {
        tabBar.addSubview(composeButton)
        
        let count = CGFloat(childViewControllers.count)
        //将内缩进的宽度减少,能够让按钮的宽度变大,盖住容错点,防止穿帮
        let w = tabBar.bch_width / count - 1
        
        //CGRectInset 内边距
        composeButton.frame = tabBar.bounds.insetBy(dx: 2 * w, dy: 0)
        
        composeButton.addTarget(self, action:#selector(WBMainViewController.composeStatusClick), for: .touchUpInside)
    }
    
    /// 设置子控制器
    private func setUpChildViewControllers() {
        
        let array = [
            ["clsName":"WBHomeViewController","title":"首页","imageName":"tabbar_home"],
            ["clsName":"WBMessageViewController","title":"消息","imageName":"tabbar_message"],
            ["clsName":"UIViewController"],
            ["clsName":"WBDiscoverViewController","title":"发现","imageName":"tabbar_discover"],
            ["clsName":"WBProfileViewController","title":"我的","imageName":"tabbar_profile"],
        ]
        
        var arrayM = [UIViewController]()
        for dict in array {
            arrayM.append(controller(dict:dict))
        }
        viewControllers = arrayM
    }
    
    /// 使用字典创建一个子控制器
    ///
    /// - parameter dict: 信息字典(clsName,title,imageName)
    ///
    /// - returns: 子控制器
    private func controller(dict:[String:String]) -> UIViewController {
        
        //1.取得字典内容
        guard let clsName = dict["clsName"],
            let title = dict["title"],
            let imageName = dict["imageName"],
            let cls = NSClassFromString(Bundle.main.nameSpace + "." + clsName) as? UIViewController.Type
            
        else {
            return UIViewController()
        }
        
        //2.创建控制器
        let vc = cls.init()
        
        //3.设置属性(标题,tabbar的标题字体)
        vc.title = title
        
        vc.tabBarItem.image = UIImage(named:imageName)?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.selectedImage = UIImage(named:imageName + "_highlighted")?.withRenderingMode(.alwaysOriginal)
        
        let attributes = [NSForegroundColorAttributeName:UIColor.lightGray,
                                  NSFontAttributeName:UIFont.systemFont(ofSize: 12)]
        let selectedAttributes = [NSForegroundColorAttributeName:UIColor.orange,
                          NSFontAttributeName:UIFont.systemFont(ofSize: 12)]
        
        vc.tabBarItem.setTitleTextAttributes(attributes, for: .normal)
        vc.tabBarItem.setTitleTextAttributes(selectedAttributes, for: .selected)
        
        let nav = WBNavigationController(rootViewController: vc)
        
        return nav
    }
    
    // MARK: - UITableViewDataSource
    // MARK: - UITableViewDelegate
    // MARK: - Custom Delegates
    // MARK: – Getters and Setters
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
