//
//  DemoTableViewCell.swift
//  SeasonsDB
//
//  Created by Parth Adroja on 2/21/16.
//  Copyright © 2016 Parth Adroja. All rights reserved.
//

import UIKit
import FoldingCell

class DemoTableViewCell: FoldingCell{

    @IBOutlet weak var IBlblPrice: UILabel!
    @IBOutlet weak var IBviewImage: UIImageView!
    @IBOutlet weak var IBlblEpisodeName: UILabel!
    @IBOutlet weak var IBlblSeriesName: UILabel!
  
    @IBOutlet weak var IBlblSummary: UILabel!
    override func awakeFromNib() {
        foregroundView.layer.cornerRadius = 10
        foregroundView.layer.masksToBounds = true
        super.awakeFromNib()
    }
    
    override func animationDuration(itemIndex:NSInteger, type:AnimationType)-> NSTimeInterval {
        
        let durations = [0.33, 0.26, 0.26]
        return durations[itemIndex]
    }


}
