//
//  MainTableViewController.swift
//  SeasonsDB
//
//  Created by Parth Adroja on 2/21/16.
//  Copyright © 2016 Parth Adroja. All rights reserved.
//

import UIKit
import FoldingCell
import Alamofire
import Haneke


class MainTableViewController: UITableViewController {

    var myTVResponse : TVFeedsModel?

    let kCloseCellHeight: CGFloat = 125
    let kOpenCellHeight: CGFloat = 340
    
    let kRowsCount = 10
    
    var cellHeights = [CGFloat]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        createCellHeightsArray()
        self.tableView.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)

        let tvURL = "https://itunes.apple.com/us/rss/toptvepisodes/limit=10/json"
        Alamofire.request(.GET, tvURL).responseObject("feed") { (response: Response<TVFeedsModel, NSError>) in
            self.myTVResponse = response.result.value
            self.tableView.performSelectorOnMainThread("reloadData", withObject: nil, waitUntilDone: false)
        }
    }

    // MARK: configure
    func createCellHeightsArray() {
        for _ in 0...kRowsCount {
            cellHeights.append(kCloseCellHeight)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if cell is DemoTableViewCell {
            let foldingCell = cell as! DemoTableViewCell
            foldingCell.backgroundColor = UIColor.clearColor()
            if cellHeights[indexPath.row] == kCloseCellHeight {
                foldingCell.selectedAnimation(false, animated: false, completion:nil)
            } else {
                foldingCell.selectedAnimation(true, animated: false, completion: nil)
            }
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FoldingCell", forIndexPath: indexPath) as! DemoTableViewCell
        let cellData = myTVResponse?.arrEntry![indexPath.row]
        if let imageUrl = cellData?.imImageHigh {
            cell.IBviewImage.hnk_setImageFromURL(NSURL(string: imageUrl)!)
        }
        cell.IBlblEpisodeName.text = cellData?.imName
        cell.IBlblSeriesName.text = cellData?.imArtist
        cell.IBlblPrice.text = cellData?.imPrice
        cell.IBlblSummary.text = cellData?.summary
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
    }
    
    // MARK: Table vie delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! DemoTableViewCell
        
        if cell.isAnimating() {
            return
        }
        
        var duration = 0.0
        if cellHeights[indexPath.row] == kCloseCellHeight { // open cell
            cellHeights[indexPath.row] = kOpenCellHeight
            cell.selectedAnimation(true, animated: true, completion: nil)
            duration = 0.5
        } else {// close cell
            cellHeights[indexPath.row] = kCloseCellHeight
            cell.selectedAnimation(false, animated: true, completion: nil)
            duration = 0.8
        }
        
        UIView.animateWithDuration(duration, delay: 0, options: .CurveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
            }, completion: nil)
        
        
    }
}
