//
//  OwnerCvPageTableViewCell.swift
//  CV_Maker_App
//
//  Created by Dmitriy Mkrtumyan on 25.07.23.
//

import UIKit

class OwnerCvPageTableViewCell: UITableViewCell {

    @IBOutlet weak private var infoLabel: UILabel!
    
    func setup(info: Any) {
        infoLabel.text = String(describing: info)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        infoLabel.numberOfLines = 0
    }
    
}
