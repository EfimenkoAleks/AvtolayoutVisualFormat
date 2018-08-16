//
//  ViewController.swift
//  AutolayoutVisualFormat
//
//  Created by mac on 14.08.2018.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var moveImageView: UIImageView!
    
    @IBOutlet weak var horizontal: NSLayoutConstraint!
    /*
 
 [view1]-[view2] - 8 px
     
     H:[view1]-10-[view2] -> горизонтальная связь
     
     V:[view1]-10-[view2] -> вертикальная связь
     
 superview - "|"
     |-10-[textField]-10-| -> левая сторона закреплена на 10 пикселей от супервю и правая на 10 пикселов
     
     [view1 (100)] - 100px -> размер вю 100 пикселов
     
     [button1(100)]-20-[button2(==button1)] -> ширина батон1 100 пикселов и батон2 = батон1 и между ними 20 пикс
     
     Flush Views
     [view1][view2] -> вю1 прилягает к вю2
     
     Prioritet
     [view1(100@20)]
     
 */
    
    var headerView: UIView!
    var titlLabel: UILabel!
    var descLabel: UILabel!
    var imageView: UIImageView!
    var buttonStart: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.initViews()
        self.createVFL()
    }
    
    func initViews() {
        self.headerView = UIView()
        self.headerView.translatesAutoresizingMaskIntoConstraints = false
        self.headerView.backgroundColor = UIColor.lightGray
        self.view.addSubview(self.headerView)
        
        self.titlLabel = UILabel()
        titlLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titlLabel.font = UIFont.systemFont(ofSize: 10.0)
        self.titlLabel.numberOfLines = 0
        self.titlLabel.preferredMaxLayoutWidth = 150.0
        self.titlLabel.backgroundColor = UIColor.yellow
        self.titlLabel.text = "UITextView displays a region that can contain multiple lines of editable text. When a user taps a text view, a keyboard appears; when a user taps Return in the keyboard, the keyboard disappears and the text view can handle the input in an application-specific way. You can specify attributes, such as font, color, and alignment, that apply to all text in a text view."
        self.headerView.addSubview(self.titlLabel)
        
        self.descLabel = UILabel()
        self.descLabel.translatesAutoresizingMaskIntoConstraints = false
        self.descLabel.font = UIFont.systemFont(ofSize: 14.0)
        self.descLabel.backgroundColor = UIColor.green
        self.descLabel.text = "Autor Aleksandr"
        self.headerView.addSubview(self.descLabel)
        
        self.imageView = UIImageView()
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.contentMode = UIViewContentMode.scaleToFill
        self.imageView.backgroundColor = UIColor.red
        self.headerView.addSubview(imageView)
        
        self.buttonStart = UIButton.init(type: UIButtonType.system)
        self.buttonStart.translatesAutoresizingMaskIntoConstraints = false
        self.buttonStart.setTitle("Start", for: UIControlState.normal)
        self.buttonStart.addTarget(self, action: #selector(self.startMove), for: UIControlEvents.touchUpInside)
        self.headerView.addSubview(buttonStart)
        
        DispatchQueue.global().async {
            let car = UIImage(data: try! Data(contentsOf: URL(string: "https://media.istockphoto.com/photos/classic-black-car-in-garage-picture-id862415786")!))
            
            let cofe = UIImage(data: try! Data(contentsOf: URL(string: "https://media.istockphoto.com/photos/happy-coffee-cup-picture-id508347326")!))
            
            DispatchQueue.main.async {
                self.imageView.image = car
                self.moveImageView.image = cofe
                self.moveImageView.contentMode = UIViewContentMode.scaleToFill
            }
        }
    }
    
    func createVFL() {
        
        let views = Dictionary(dictionaryLiteral: ("headerView",headerView), ("titleLabel",titlLabel), ("descLabel",descLabel), ("imageView",imageView), ("buttonStart",buttonStart))
        
        let metrics = Dictionary(dictionaryLiteral: ("imageWidth",200), ("imageHeight",300), ("padding",15))
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[headerView]|", options: [], metrics: metrics, views: views ))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-35-[headerView]", options: [], metrics: metrics, views: views))
        self.headerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-padding-[imageView(imageWidth)]-padding-[titleLabel]-padding-|", options: [], metrics: metrics, views: views))
        
        self.headerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-padding-[titleLabel]->=0-[descLabel]-padding-|", options: NSLayoutFormatOptions.alignAllRight, metrics: metrics, views: views))
        
        self.headerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-padding-[imageView(imageHeight)]->=padding-[buttonStart]-padding-|", options: NSLayoutFormatOptions.alignAllCenterX, metrics: metrics, views: views))
        
        
    }
    
    @objc func startMove(sender: UIButton) {
        
        sender.isEnabled = false
        
        UIView.animateKeyframes(withDuration: 5.0, delay: 0.0, options: UIViewKeyframeAnimationOptions.calculationModeCubicPaced, animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5, animations: {
                                self.horizontal.constant = 250.0
                                self.view.layoutIfNeeded()
                            })
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.25, animations: {
                                self.horizontal.constant = 25.0
                                self.view.layoutIfNeeded()
                            })
            UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.125, animations: {
                                self.horizontal.constant = 250.0
                                self.view.layoutIfNeeded()
                            })
            UIView.addKeyframe(withRelativeStartTime: 0.875, relativeDuration: 0.0625, animations: {
                                self.horizontal.constant = 25.0
                                self.view.layoutIfNeeded()
                            })
            UIView.addKeyframe(withRelativeStartTime: 0.9375, relativeDuration: 0.3125, animations: {
                                self.horizontal.constant = 250.0
                                self.view.layoutIfNeeded()
                            })
            UIView.addKeyframe(withRelativeStartTime: 0.96875, relativeDuration: 0.015625, animations: {
                                self.horizontal.constant = 25.0
                                self.view.layoutIfNeeded()
                            })
        }) { (finished: Bool) in
            sender.isEnabled = true
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

