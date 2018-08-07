//
//  StockModel.swift
//  StockFusion
//
//  Created by Landry Achia Ndong on 2018-07-22.
//  Copyright © 2018 Landry Achia Ndong. All rights reserved.
//

//Will hold the model for all stock that will be displayed on the STOCKS tab on main view
//Hence will contain an array of Stocks [Stock]

import UIKit

enum StockTracking{
    case tracking
    case notTracking
}

class StockModel
{
    
    //variable will hold the image of stock
    var stockImage: UIImage?
    
    //variable will hold the symbol of stock data
    var symbol: String?
    
    //var will hold the name of stock data
    var companyName: String?
    
    //price of stock
    var stockPrice: String?
    
    //currency of stock
    var currency: String?
    
    //priceOpen of Stock
    var priceOpen: String?
    
    //assigning the day high of stock
    var dayHigh: String?
    
    //assigning the day low of stock
    var dayLow: String?
    
    //assigning the 52 week high of stock
    var fiftyTwoWeekHigh: String?
    
    //assigning the 52 week low of stock
    var fiftyTwoWeekLow: String?
    
    //assigning the daychange
    var dayChange: String?
    
    //assigning the change percent of stock
    var changePercent: String?
    
    //assigning close yeserday value of stock
    var closeYesterday: String?
    
    //assigning the market cap of stock
    var marketCap: String?
    
    //assigning the volume of stock
    var stockVolume: String?
    
    //assigning the last trade time of stock
    var lastTradeTime: String?
    
    //tracking currentStock Data
    var tracking: StockTracking
    
    init(stockSymbol: String, stockCompanyName: String, logoImage: String, price: String, currency: String, openPrice: String, dayHigh: String, dayLow: String, fiftyTwoWeekHigh: String, fiftyTwoWeekLow: String, dayChange: String, changePercent: String, closeYesterday: String, marketCap: String, stockVol: String,  lastTradeTime: String)
    {
        self.symbol = stockSymbol
        self.companyName = stockCompanyName
        
        if let image = UIImage(named: logoImage){
            self.stockImage = image
        }else{
            self.stockImage = UIImage(named: "default")!
        }
        
        self.stockPrice = price
        self.currency = currency
        self.priceOpen = openPrice
        self.dayHigh = dayHigh
        self.dayLow = dayLow
        self.fiftyTwoWeekHigh = fiftyTwoWeekHigh
        self.fiftyTwoWeekLow = fiftyTwoWeekLow
        self.dayChange = dayChange
        self.changePercent = changePercent
        self.closeYesterday = closeYesterday
        self.marketCap = marketCap
        self.lastTradeTime = lastTradeTime
        self.stockVolume = stockVol
        //by default not tracking any currency
        self.tracking = .notTracking
    }
}
