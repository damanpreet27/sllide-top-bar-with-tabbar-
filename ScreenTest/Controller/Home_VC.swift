//
//  Home_VC.swift
//  ScreenTest
//
//  Created by Digittrix  on 04/07/20.
//  Copyright © 2020 Digittrix . All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
import NVActivityIndicatorView
import SJSegmentedScrollView


class Home_VC: SJSegmentedViewController
{
    //MARK:- IBOutlet
  
    
    //MARK:- Requirements
    
     var items = ["Overview","Additional info","Contact","Comment"]
     var selectedSegment: SJSegmentTab?
   
    //MARK:-  view did load
   override func viewDidLoad()
   {
     
  
    //initialize tabs
      if let storyboard = self.storyboard
      {
        
        
          let headerController = storyboard
              .instantiateViewController(withIdentifier: "HeaderViewController1")

          let firstViewController = storyboard
              .instantiateViewController(withIdentifier: "Overview_VC")
          firstViewController.title = "Overview"

          let secondViewController = storyboard
              .instantiateViewController(withIdentifier: "AdditionalInfo_VC")
          secondViewController.title = "Additional info"

          let thirdViewController = storyboard
                       .instantiateViewController(withIdentifier: "Contact_VC")
                   thirdViewController.title = "Contact"

          let fourthViewController = storyboard
              .instantiateViewController(withIdentifier: "Comment_VC")
          fourthViewController.title = "Comment"

          headerViewController = headerController
          segmentControllers = [firstViewController,
                                     secondViewController,
                                     thirdViewController,
                                     fourthViewController]
          headerViewHeight = 420
          selectedSegmentViewHeight = 2.0
          headerViewOffsetHeight = 60
          segmentTitleColor = .gray
          selectedSegmentViewColor = #colorLiteral(red: 0.229046911, green: 0.7467957139, blue: 0.9548043609, alpha: 1)
          segmentShadow = SJShadow.light()
          showsHorizontalScrollIndicator = false
          showsVerticalScrollIndicator = false
          segmentBounces = false
          delegate = self
      }

      title = "Segment"
      super.viewDidLoad()
  }
    
  
  
 
 
}
extension Home_VC: SJSegmentedViewControllerDelegate {

    func didMoveToPage(_ controller: UIViewController, segment: SJSegmentTab?, index: Int) {

        if selectedSegment != nil {
            selectedSegment?.titleColor(.lightGray)
        }

        if segments.count > 0 {

            selectedSegment = segments[index]
            selectedSegment?.titleColor(.red)
        }
    }
}

