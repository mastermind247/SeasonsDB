//
//  ViewController.swift
//  SeasonsDB
//
//  Created by Parth Adroja on 2/21/16.
//  Copyright © 2016 Parth Adroja. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    var myTVResponse : TVFeedsModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tvURL = "https://itunes.apple.com/us/rss/toptvepisodes/limit=10/json"
        Alamofire.request(.GET, tvURL).responseObject("feed") { (response: Response<TVFeedsModel, NSError>) in
            
            let tvResponse = response.result.value
            
            for tvData in (tvResponse?.arrEntry)! {
                print(tvData.imArtist)
                print(tvData.imImageHigh)
                print(tvData.imName)
                print(tvData.imPrice)
                print(tvData.imReleaseDate)
                print(tvData.summary)
                print(tvData.rights)
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

