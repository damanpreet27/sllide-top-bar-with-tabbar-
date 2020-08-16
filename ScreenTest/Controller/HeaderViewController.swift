//
//  HeaderViewController.swift
//  SJSegmentedScrollView
//
//  Created by Subins Jose on 13/06/16.
//  Copyright © 2016 Subins Jose. All rights reserved.
//

import UIKit
import SDWebImage
import Alamofire
import SwiftyJSON
import SDWebImage
import NVActivityIndicatorView


class HeaderViewController: BaseViewController
{
    //MARK:- IBOutlet
    @IBOutlet weak var imgEvent: UIImageView!
    
    @IBOutlet weak var lblSeen: UILabel!
    @IBOutlet weak var lblLike: UILabel!
    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var lblPeople: UILabel!
    
    //MARK:- IBAction
    override func viewDidLoad()
    {
        super.viewDidLoad()
                                     
        
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
         getEventDetail()
    }

   
    
  //MARK:- Web Services
       func getEventDetail()
       {
          self.objHudShow()
                         
           let params =
                       [
                           "latitude" : "28.1245",
                           "longitude" : "78.1245",
                           "event_id" : "12",
                           "user_id" : "00"
                                           
                       ]
                       print(params)
                           
                       Alamofire.request("http://saudicalendar.com/api/user/getEventDetail", method: .post, parameters: params, encoding: URLEncoding.default).responseJSON{ response in
                                
                       self.objHudHide()
                       switch response.result
                       {
                               case .success (let data):
                               print(data)
                                    
                                    let json = JSON(response.result.value!);
                                    print(json["error"])
                                    
                                    if json["error"] == false
                                    {
                                        let jsonObject = response.result.value
                                        let jsonDict : Dictionary = jsonObject as! Dictionary<String,Any>
                                          
                                        if let dataTempDict : Dictionary = jsonDict["data"] as? Dictionary<String,Any>
                                        {
                                           if let ev_image : NSArray = dataTempDict["ev_image"] as? NSArray
                                            {
                                                    if let imageDict: Dictionary = ev_image[0] as? Dictionary<String,Any>
                                                    {
                                                            if let image : String = imageDict["image"] as? String
                                                            {
                                                                    self.imgEvent.sd_setShowActivityIndicatorView(true)
                                                                    self.imgEvent.sd_setIndicatorStyle(UIActivityIndicatorView.Style.gray)
                                                                                                                                                 
                                                                    let urlNew : String = image.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                                                                    let url = URL(string: urlNew)
                                                                    self.imgEvent.sd_setImage(with: url, placeholderImage:nil)
                                                            }
                                                    }
                                                
                                                
                                            }
                                            if let ev_views : String = dataTempDict["ev_views"] as? String
                                            {
                                                self.lblSeen.text = ev_views
                                            }
                                            if let ev_like : String = dataTempDict["ev_like"] as? String
                                            {
                                                self.lblLike.text = ev_like
                                            }
                                            if let ev_is_fav : String = dataTempDict["ev_is_fav"] as? String
                                            {
                                                self.lblPeople.text = ev_is_fav
                                            }
                                            if let distance : String = dataTempDict["distance"] as? String
                                            {
                                                self.lblDistance.text = distance
                                            }
                                            
                                        }
                                       
                                     
                                    }
                                    else
                                    {
                                      //self.view!.makeToast(json["status"].rawString(), duration: 2, position: .bottom)
                                    }
                                    
                                    break
                                    
                                case .failure:
                                    
                                   
                                    let alertViewController = UIAlertController(title: NSLocalizedString("Alert!", comment: ""), message: NSLocalizedString("Something went wrong please try again", comment: "") , preferredStyle: .alert)
                                    let okAction = UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .default) { (action) -> Void in
                                        
                                    }
                                    alertViewController.addAction(okAction)
                                    self.present(alertViewController, animated: true, completion: nil)
                                    
                                    break
                                }
                            }
                        }
           
}
