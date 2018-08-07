//
//  StockAllViewController.swift
//  StockFusion
//
//  Created by Landry Achia Ndong on 2018-07-30.
//  Copyright © 2018 Landry Achia Ndong. All rights reserved.
//

import UIKit



class StockAllViewController: UITableViewController {
    
    
    
    //var of an array of dictionaries with string value and string key to hold stock data
    var stocks = [[String: String]]()
    var stockModelObjects = [StockModel]()
    var stockHistoryObjects = [StockHistoryModel]()
    var stockRemoteState = StockRemoteDataShared()
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Stocks"
        
        tableView.register(StockTabTableViewCell.self, forCellReuseIdentifier: "singleStockCell")

        //showing the loading/spinner while data is pulled from api
        ANLoader.showLoading("Laoding", disableUI: true)
        ANLoader.pulseAnimation = true
        ANLoader.activityColor = .white
        ANLoader.showFadeOutAnimation = true
        ANLoader.activityBackgroundColor = .darkGray
        
        Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(hideLoader), userInfo: nil, repeats: false)
        
        //calling methodds in background to avoid UI freezes but Table view updates and notifications will be run from main thread
        performSelector(inBackground: #selector(fetchRemoteStockData), with: nil)
        
        stockRemoteState.stockSharedModelObjects = stockModelObjects
      
        
        
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        let tabBar = tabBarController as! ViewController
        tabBar.stockModelObjectsFromBaseController = stockModelObjects
    }
   
    
   
    
    
    //MARK: method to handle data fetching from api calls
    @objc func fetchRemoteStockData(){
        //url string for api data
        let urlString: String
        
        //pulling data type based on tab bar item been clicked
            urlString = "https://www.worldtradingdata.com/api/v1/stock?symbol=AAPL,FB,TWTR,AMZN,MSFT,PYPL,ACWD,AMD,PF,PNK,GM,TDBOF&api_token=OKZKE67mZb20gHpqKN9N4k9Rba4B5b3h7eWdfZBa1x6f8E0U2A37Y72HuZis"
            //using GCD application to ensure safe loading of data without screen freezes while pulling data
            //and proper qos since which is .userInitiated to ensure data is given higher priority in loading from background
            //async() closure will be used
            
            if let url = URL(string: urlString){
                if let stockData = try? String(contentsOf: url){
                    let stockJson = JSON(parseJSON: stockData)
                    
                    if (stockJson["symbols_returned"].intValue > 0) {
                        self.parse(json: stockJson)
                        print("stock array is not empty")
                        return
                    }
                }
            }
            print(self.stocks)
            
        
            //show error message if above code fails
            performSelector(onMainThread: #selector(showFetchDataError), with: nil, waitUntilDone: false)
        
    }
    
    
    //MARK: method for JSON parsing
    //method to handle the parsing of json data
    func parse(json: JSON) {
        for result in json["data"].arrayValue{
            //assigning variable for symbol which will be the symbol of stock data
            let symbol = result["symbol"].stringValue
            
            //assigning variable for company which will be the detail on cell
            let companyName = result["name"].stringValue
            
            //assigning variable price for each stock data to price
            let stockPrice = result["price"].stringValue
            
            //assiginng the currency on stock
            let currency = result["currency"].stringValue
            
            //assigning the open price of stock item
            let priceOpen = result["price_open"].stringValue
            
            //assigning the day high of stock
            let dayHigh = result["day_high"].stringValue
            
            //assigning the day low of stock
            let dayLow = result["day_low"].stringValue
            
            //assigning the 52 week high of stock
            let fiftyTwoWeekHigh = result["52_week_high"].stringValue
            
            //assigning the 52 week low of stock
            let fiftyTwoWeekLow = result["52_week_low"].stringValue
            
            //assigning the daychange
            let dayChange = result["day_change"].stringValue
            
            //assigning the change percent of stock
            let changePercent = result["change_pct"].stringValue
            
            //assigning close yeserday value of stock
            let closeYesterday = result["close_yesterday"].stringValue
            
            //assigning the market cap of stock
            let marketCap = result["market_cap"].stringValue
            
            //assigning the volume of stock
            let stockVolume = result["volume"].stringValue
            
            //assigning the last trade time of stock
            let lastTradeTime = result["last_trade_time"].stringValue
            
            
            
            //adding the the cell info to the dictionary
            let dicObjectOfStockData = ["symbol": symbol, "companyName": companyName, "stockPrice": stockPrice, "currency": currency, "priceOpen": priceOpen, "day_high": dayHigh, "day_low": dayLow, "52_week_high": fiftyTwoWeekHigh, "52_week_low": fiftyTwoWeekLow, "day_change": dayChange, "change_pct":changePercent, "close_yesterday": closeYesterday, "market_cap": marketCap, "volume": stockVolume, "last_trade_time": lastTradeTime]
            
            //making the object from stock Model
            let stockModel = StockModel(stockSymbol: symbol, stockCompanyName: companyName, logoImage: symbol, price: stockPrice, currency: currency, openPrice: priceOpen, dayHigh: dayHigh, dayLow: dayLow, fiftyTwoWeekHigh: fiftyTwoWeekHigh, fiftyTwoWeekLow: fiftyTwoWeekLow, dayChange: dayChange, changePercent: changePercent, closeYesterday: closeYesterday, marketCap: marketCap, stockVol: stockVolume, lastTradeTime: lastTradeTime)
            
            //adding the object from api to stock array
            self.stocks.append(dicObjectOfStockData)
            self.stockModelObjects.append(stockModel)
            
            
        }
        
        //refreshing tableview after each object is added
        //        tableView.reloadData()
        //perform a selector so to reload UI only on main thread and not on background
        tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
    }
    
    
    
    //MARK: protocols for table view
    
    //function returns number of rows based on number of objects in array.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stockModelObjects.count
    }
    
    //method displays what will appear in each cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "stockCellData", for: indexPath) as! StockTabTableViewCell
        
        //        let stockSection = self.stockModelObjects[indexPath.section]
        
        let singleStock = stockModelObjects[indexPath.row]
        print(stocks)
        
        //        cell.textLabel?.text = "Title"
        cell.setupData(data: singleStock)
//        cell.companyName.text = singleStock.companyName?.uppercased()
//        cell.stockSymbol.text = singleStock.symbol
//        cell.stockPrice.text =  singleStock.stockPrice!
        //        cell.detailTextLabel?.text = "Details"
        return cell
    }
    
    //method enables the movement of rows during editing
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let moveCell = self.stockModelObjects[sourceIndexPath.row]
        stockModelObjects.remove(at: sourceIndexPath.row)
        stockModelObjects.insert(moveCell, at: destinationIndexPath.row)
    }
    
    //MARK: methods to modify each cell for table view
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let whiteRoundedView: UIView = UIView(frame: CGRect(x: 0, y: 10, width: self.view.frame.size.width, height: 70))
        
        whiteRoundedView.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 5.0, 1.0, 0.5])
        whiteRoundedView.layer.masksToBounds = false
        whiteRoundedView.layer.cornerRadius = 3.0
        whiteRoundedView.layer.shadowOffset = CGSize(width: -1, height: 1)
        whiteRoundedView.layer.shadowOpacity = 0.5
        
        cell.contentView.addSubview(whiteRoundedView)
        cell.contentView.sendSubview(toBack: whiteRoundedView)
    }
    
    
    
    
    //method loads details of a particular stock
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        let destination = storyBoard.instantiateViewController(withIdentifier: "StockDataDetailViewIdentifier") as! StockDataDetailViewController
        destination.stockModelDetailsForSelected = [stockModelObjects[indexPath.row]]
        navigationController?.pushViewController(destination, animated: true)
    }
    
    
    //MARK: method to show fetched Data Error if any
    //function shows the error to notify user whether or not data was fetched from api successfully and using @objc so it will be called with selected on maintrain only only since it is a UI
    @objc func showFetchDataError() {
        let ac = UIAlertController(title: "Fetch Stock Data Error!", message: "Failed to fetch data from source, Please check to see if your network or mobile data is set correctly.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(ac, animated: true)
        
        
    }
    
    
    //MARK: functions that handle the spinner hiding and Loading
    @objc func hideLoader(){
        ANLoader.hide()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
//custom vars for notification
extension Notification.Name {
     static let didPostFetchedStockData = Notification.Name("com.landry.post.fetchStockData")
}
