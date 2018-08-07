//
//  StockTabTableViewCell.swift
//  StockFusion
//
//  Created by Landry Achia Ndong on 2018-07-23.
//  Copyright © 2018 Landry Achia Ndong. All rights reserved.
//

import UIKit

class StockTabTableViewCell: UITableViewCell {
    
    //Mark: custom cell outlets

    @IBOutlet weak var symbolOfStock: UILabel!
    
    @IBOutlet weak var nameOfCompany: UILabel!
    
    @IBOutlet weak var priceOfStock: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupData(data: StockModel) {
        self.nameOfCompany!.text = data.companyName
        self.symbolOfStock!.text = data.symbol
        self.priceOfStock!.text = data.stockPrice
    }

}
