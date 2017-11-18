//
//  ViewController.swift
//  AutoLayout
//
//  Created by mac on 2017/11/6.
//  Copyright © 2017年 modi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var UserNameField: UITextField!
    @IBOutlet weak var PassWordField: UITextField!
    @IBOutlet weak var PassWordLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI(){
        let securePwd = NSLocalizedString("SecurityPassWord", comment: "A kind of invisible text")
        let password = NSLocalizedString("PassWord", comment: "A visible text")
        //格式化不同地区不同显示的字符串：如时间日期格式、货币格式等
        //String.localizedStringWithFormat("date: %@ time: %@", date, time)
        PassWordLabel.text = secure ? securePwd : password
        PassWordField.isSecureTextEntry = secure
        //
        nameLabel.text = loginUser?.name
        companyLabel.text = loginUser?.company
        //User是Model，Model中不能有View故用扩展将View放到Controller中
//        imageView.image = loginUser?.image
        //用设置好宽高比的Image代替imageView.image
        image = loginUser?.image
    }
    var secure: Bool = false {
        didSet {
            updateUI()
        }
    }
    @IBAction func SecurityPassword() {
        secure = !secure
    }
    
    var loginUser: User? {
        didSet {
            updateUI()
        }
    }
    @IBAction func Login() {
        loginUser = User.login(login: UserNameField.text ?? "", password: PassWordField.text ?? "")
    }
    var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            //不能在计算型属性中操作自己
//            image = newValue
            //当ImageView不为空执行
            if let contrainedView = imageView {
                //当设置Image时执行
                if let newImage = newValue {
                    aspectRatioConstrain = NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem: imageView, attribute: .height, multiplier: newImage.aspectRatio, constant: 0)
                }else{
                    aspectRatioConstrain = nil
                }
            }
        }
    }
    //设置约束保持图片宽高比
    var aspectRatioConstrain: NSLayoutConstraint? {
        willSet {
            if let existingConstraint = aspectRatioConstrain {
                imageView.removeConstraint(existingConstraint)
            }
        }
        didSet {
            if let newConstraint = aspectRatioConstrain {
                imageView.addConstraint(newConstraint)
            }
        }
    }
}
//User是Model，Model中不能有View故用扩展将View放到Controller中
extension User {
    var image: UIImage? {
        if let image = UIImage(named: login) {
            return image
        }else{
            return UIImage(named: "unknowns User")
        }
    }
}
//扩展出UIImage宽高比
extension UIImage {
    var aspectRatio: CGFloat {
        return size.height != 0 ? size.width / size.height : 0
    }
}

