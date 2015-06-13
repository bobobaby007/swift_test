//
//  ViewController.swift
//  swift_test
//
//  Created by Bob Huang on 15/5/26.
//  Copyright (c) 2015年 4view. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITableViewDelegate,UIImagePickerControllerDelegate{


    //var timeButtons: UIButton
    var buttons=[UIButton]()
    
    @IBOutlet var btn:UIButton?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let Request=YYHRequest(url: NSURL(string: "http://www.baidu.com")!)
        
        Request.completionHandler={response, data, error in
           print(data)
        }
        // Request.loadRequest()
        
        
        
        for i in self.view.subviews{
            
            if i is UIButton{
                //var btn:UIButton
                var anniu=i as? UIButton
                
                buttons.append(anniu!)
                
                                //btn.hidden=true
              anniu!.setTitle("haha", forState: UIControlState.Normal)
                let alertV = UIAlertView()
                alertV.message=anniu?.restorationIdentifier
                alertV.title="我说吧"
                alertV.addButtonWithTitle("好的")
                //alertV.show()
               // anniu!.addTarget(self, action:"aclickAction:", forControlEvents: UIControlEvents.TouchUpInside)
                
            }
        }
        
        
        //print(self.view.subviews)
        
        
    }
    
    
    
    
    @IBAction func aclickAction(button:UIButton){
       if button.restorationIdentifier!=="3"{
        println("ok")
        }
         println(button.restorationIdentifier)
    }

    
    //-----打开相册
    
    
    override func viewDidAppear(animated: Bool) {
        println(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

