//
//  StockDataDetailViewController.swift
//  StockFusion
//
//  Created by Landry Achia Ndong on 2018-07-17.
//  Copyright © 2018 Landry Achia Ndong. All rights reserved.
//

import UIKit
import WebKit
import Motion
import Material
import SwiftyButton



class StockDataDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
    
    
    //this var is a custom tableView outlet to fill just half the screen size
    @IBOutlet weak var tableForStockDetails: UITableView!
    
    //Var will hold an array of stock history data to plot the graph in graph view
     var stockHistoryDataForGraph = [StockHistoryModel]()
    
    //action when the Graph History button is clicked
    @IBAction func goToGraphHistory(_ sender: Any) {
        
        performSegue(withIdentifier: "showGraphHistory", sender: self)
    }
    
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 14
    }
    
    //method to modify height for cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let whiteRoundedView: UIView = UIView(frame: CGRect(x: 0, y: 10, width: self.view.frame.size.width, height: 70))
        
        whiteRoundedView.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 0.5, 0.3, 0.8])
        whiteRoundedView.layer.masksToBounds = false
        whiteRoundedView.layer.cornerRadius = 3.0
        whiteRoundedView.layer.shadowOffset = CGSize(width: -1, height: 1)
        whiteRoundedView.layer.shadowOpacity = 0.5
        cell.contentView.addSubview(whiteRoundedView)
        cell.contentView.sendSubview(toBack: whiteRoundedView)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellForTableForStockDetails", for: indexPath)
        cell.frame = UIEdgeInsetsInsetRect(cell.frame, UIEdgeInsetsMake(10, 10, 10, 10))
                if indexPath.row == 0 {
                    cell.textLabel?.text = "Symbol"
                    cell.detailTextLabel?.text = stockModelDetailsForSelected[0].symbol!
                    let priceCheck = stockModelDetailsForSelected[0].changePercent!
                    if priceCheck.contains("-"){
                        cell.backgroundColor = UIColor.red
                    }
                    
                }else if indexPath.row == 1 {
                    cell.textLabel?.text = "Currency"
                    cell.detailTextLabel?.text = stockModelDetailsForSelected[0].currency!
                }else if indexPath.row == 2 {
                    cell.textLabel?.text = "Price"
                    cell.detailTextLabel?.text = stockModelDetailsForSelected[0].stockPrice!
                    let priceCheck = stockModelDetailsForSelected[0].changePercent!
                    if priceCheck.contains("-"){
                        cell.backgroundColor = UIColor.red
                    }
                }else if indexPath.row == 3 {
                    cell.textLabel?.text = "Open Price"
                    cell.detailTextLabel?.text = stockModelDetailsForSelected[0].priceOpen!
                }else if indexPath.row == 4 {
                    cell.textLabel?.text = "Day High"
                    cell.detailTextLabel?.text = stockModelDetailsForSelected[0].dayHigh!
                }else if indexPath.row == 5 {
                    cell.textLabel?.text = "Day Low"
                    cell.detailTextLabel?.text = stockModelDetailsForSelected[0].dayLow!
                }else if indexPath.row == 6 {
                    cell.textLabel?.text = "52 Week High"
                    cell.detailTextLabel?.text = stockModelDetailsForSelected[0].fiftyTwoWeekHigh!
                }else if indexPath.row == 7 {
                    cell.textLabel?.text = "52 Week Low"
                    cell.detailTextLabel?.text = stockModelDetailsForSelected[0].fiftyTwoWeekLow!
                }else if indexPath.row == 8 {
                    cell.textLabel?.text = "Day Change"
                    cell.detailTextLabel?.text = stockModelDetailsForSelected[0].dayChange!
                }else if indexPath.row == 9 {
                    cell.textLabel?.text = "Change Percent"
                    cell.detailTextLabel?.text = stockModelDetailsForSelected[0].changePercent!
                }else if indexPath.row == 10 {
                    cell.textLabel?.text = "Close Yesterday"
                    cell.detailTextLabel?.text = stockModelDetailsForSelected[0].closeYesterday!
                }else if indexPath.row == 11 {
                    cell.textLabel?.text = "Market Cap"
                    cell.detailTextLabel?.text = stockModelDetailsForSelected[0].marketCap!
                }else if indexPath.row == 12 {
                    cell.textLabel?.text = "Volume"
                    cell.detailTextLabel?.text = stockModelDetailsForSelected[0].stockVolume!
                }else if indexPath.row == 13 {
                    cell.textLabel?.text = "Last Trade Time"
                    cell.detailTextLabel?.text = stockModelDetailsForSelected[0].lastTradeTime!
                }
        
        return cell
    }
    
    
    var detailStockItem: [String: String]!
    
    //var hold details for each stock object on this view
    var stockModelDetailsForSelected = [StockModel]()
    
    
 

   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //adding buy and sell button on navigation bar
        let buySellButton = UIBarButtonItem(title: "Buy/Sell", style: .plain, target: self, action: #selector(self.buySellStock))
        
        self.navigationItem.rightBarButtonItem = buySellButton
        
        //giving a background color to view
        view.backgroundColor = UIColor.darkGray
        
//        prepareRaisedButton()
        //graph button design
        let button  = PressableButton()
        
        button.colors = .init(button: .red, shadow: .white)
        button.shadowHeight = 5
        button.cornerRadius = 5
        button.depth = 0.5
        
        
    }
    
    
    //send data to Graph View Controller with prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        fetchRemoteHistoryStockData(nameOfStock: stockModelDetailsForSelected[0].symbol!)
        let destinationToGraphHistoryView : DetailStockHistroyGraphViewController = segue.destination as! DetailStockHistroyGraphViewController
        
        destinationToGraphHistoryView.detailStockObject = stockHistoryDataForGraph
    }
    
//
//    func prepareRaisedButton() {
//        let button = RaisedButton(title: "Graph History", titleColor: .white)
//        button.pulseColor = .white
//        button.backgroundColor = Color.blue.base
//
//        view.layout(button)
//            .width(ButtonLayoutMaterial.Raised.width)
//            .height(ButtonLayoutMaterial.Raised.height)
//            .center(offsetY: ButtonLayoutMaterial.Raised.offsetY)
//
//    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - Action methods for buttons on the single stock details view controller
    
    @objc func buySellStock(){
        
    }
    
    //Mark: functions to search for history from api
    
    //this method gets the stock history data from api
    func parseHistoryData(json: JSON) {
        //since json has date as object set start date
        let startDate = "2018-07-25"
        let endDate = "2015-07-01"
        
        //date formatter
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        var startDates = dateFormatter.date(from: startDate) ?? Date()
        let endDates = dateFormatter.date(from: endDate) ?? Date()
        
        //        var dateRange: [String] = []
        
        let historyData = json["history"]
        
        
        while startDates >= endDates {
            let stringDate = dateFormatter.string(from: startDates)
            
            
            let open = historyData[stringDate]["open"].stringValue
            
            //            let close = historyResult["close"].stringValue
            
            let close = historyData[stringDate]["close"].stringValue
            //            let high = historyResult["high"].stringValue
            
            
            //            let low = historyResult["low"].stringValue
            let high = historyData[stringDate]["high"].stringValue
            
            //            let volume = historyResult["volume"].stringValue
            let low = historyData[stringDate]["low"].stringValue
            
            let volume = historyData[stringDate]["volume"].stringValue
            
            //making the object from stock Model
            let stockModelHistory = StockHistoryModel()
            stockModelHistory.historyOpenPrice = open
            stockModelHistory.historyClosePrice = close
            stockModelHistory.historyHighPrice = high
            stockModelHistory.historyLowPrice = low
            stockModelHistory.historyVolume = volume
            
            //adding the object from api to stock array
            
            self.stockHistoryDataForGraph.append(stockModelHistory)
            
            startDates = Calendar.current.date(byAdding: .day, value: -1, to: startDates) ?? Date()
        }
        
    }
    
    //this function fetches the data from api
    @objc func fetchRemoteHistoryStockData(nameOfStock: String){
        
        //url string for api data
        let urlString = "https://www.worldtradingdata.com/api/v1/history?symbol=\(nameOfStock)&api_token=OKZKE67mZb20gHpqKN9N4k9Rba4B5b3h7eWdfZBa1x6f8E0U2A37Y72HuZis"
        
        //parsing data
        if let url = URL(string: urlString){
            if let stockData = try? String(contentsOf: url){
                let stockJson = JSON(parseJSON: stockData)
                self.parseHistoryData(json: stockJson)
                return
            }
            
        }
        
    }

}


