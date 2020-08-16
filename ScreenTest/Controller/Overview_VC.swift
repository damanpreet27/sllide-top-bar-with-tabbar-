//
//  Overview_VC.swift
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


class Overview_VC: BaseViewController,UICollectionViewDelegate,UICollectionViewDataSource
{

    //MARK:- IBOutlet
    @IBOutlet weak var CVEventOrgniser: UICollectionView!
    @IBOutlet weak var lblBreifDescription: UILabel!
    
    //MARK
    var arrOrganiser = NSMutableArray()
    let value = UserDefaults.standard.value(forKey: "DataValue") as? Int
    var status = 0

  
    
    //MARK:- View Life Cycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        getEventDetail()

        
    }
  
//MARK:- Collection view delegate and datasource method
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
   {
    
      return arrOrganiser.count
     
     
   }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = self.CVEventOrgniser.dequeueReusableCell(withReuseIdentifier: "CollectionCellEventOrgniser", for: indexPath) as! CollectionCellEventOrgniser
        if let tempOrganiserDict : Dictionary = arrOrganiser[indexPath.row] as? Dictionary<String,Any>
        {
            if let imgOraniser : String = tempOrganiserDict["o_logo"] as? String
            {
                 cell.imgPerson.sd_setShowActivityIndicatorView(true)
                 cell.imgPerson.sd_setIndicatorStyle(UIActivityIndicatorView.Style.gray)
                 let url = URL(string: imgOraniser)
                 cell.imgPerson.sd_setImage(with: url, placeholderImage:nil)
            }
            if let o_name : String = tempOrganiserDict["o_name"] as? String
            {
                cell.lblName.text = o_name
            }
        }
        return cell
    }
    
  //MARK:- Web Services
      func getEventDetail()
      {
       
                        
          let params =
                      [
                          "latitude" : "28.1245",
                          "longitude" : "78.1245",
                          "event_id" : "12",
                          "user_id" : "00"
                                          
                      ]
                      print(params)
                          
                      Alamofire.request("http://saudicalendar.com/api/user/getEventDetail", method: .post, parameters: params, encoding: URLEncoding.default).responseJSON{ response in
                               
                     
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
                
                                           if let tempArrayOrg : NSArray = (dataTempDict["event_organizer"] as? NSArray)?.mutableCopy() as? NSMutableArray
                                            {
                                                self.arrOrganiser = tempArrayOrg as! NSMutableArray
                                                         
                                            }
                                            if let ev_description : String = dataTempDict["ev_description"] as? String
                                            {
                                                self.lblBreifDescription.text = ev_description
                                            }
                                                      self.CVEventOrgniser.reloadData()
                                        
                                                
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
