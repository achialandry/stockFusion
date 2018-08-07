//
//  SearchTabViewController.swift
//  StockFusion
//
//  Created by Landry Achia Ndong on 2018-07-30.
//  Copyright © 2018 Landry Achia Ndong. All rights reserved.
//

import UIKit
import SearchTextField

class SearchTabViewController: UIViewController {
    
    
    
    
    

    @IBOutlet weak var stockSearch: SearchTextField!
    var stockRemoteState = StockRemoteDataShared()
    var searchableStockData = [StockModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search a stock"
        
        
    }
    
   
    override func viewDidAppear(_ animated: Bool) {
        
        stockSearch.theme.font = UIFont.systemFont(ofSize: 15)
        //stockSearch.theme = SearchTextFieldTheme.darkTheme()
        stockSearch.theme.borderColor = UIColor (red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        stockSearch.theme.separatorColor = UIColor (red: 0.9, green: 0.9, blue: 0.9, alpha: 0.5)
        stockSearch.theme.cellHeight = 70
        
        // Set specific comparision options - Default: .caseInsensitive
        stockSearch.comparisonOptions = [.caseInsensitive]
        
        // Set the max number of results. By default it's not limited
        stockSearch.maxNumberOfResults = 15
        
        
        // Start filtering after an specific number of characters - Default: 0
        stockSearch.minCharactersNumberToStartFiltering = 1
        //
       
        //update data source when user stops typing
        stockSearch.userStoppedTypingHandler = {
            if let criteria = self.stockSearch.text {
                if criteria.characters.count > 1 {
                    
                    //show loading indicator
                    self.stockSearch.showLoadingIndicator()
                    
                }
            }
        }
        
        //handle the item selected by user
        stockSearch.itemSelectionHandler = { filteredResults, itemPosition in
            //opening the stock detail  view when item is picked
            let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
            
            let destination = storyBoard.instantiateViewController(withIdentifier: "StockDataDetailViewIdentifier") as! StockDataDetailViewController
            
            let symbolOfStock = filteredResults[itemPosition].title
            var indexOfFound = 0
            
           
//            search for item in searcchableStockData
            for item in self.searchableStockData {
                print("Item Symbol: \(item.companyName) == \(symbolOfStock) \(item.companyName == symbolOfStock) ")
                if item.companyName == symbolOfStock{
                    
                    break
                }
                indexOfFound += 1
            }
            
            
            //send value to next vc
            destination.stockModelDetailsForSelected = [self.searchableStockData[indexOfFound]]
            self.navigationController?.pushViewController(destination, animated: true)
        }
        
        // 1 - Configure a simple search text field
        configuringSearchTextField()
    }
    
    

    
    override func viewWillAppear(_ animated: Bool) {
        let tabBar = tabBarController as! ViewController
        searchableStockData = tabBar.stockModelObjectsFromBaseController
        
        print(searchableStockData)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 1 - Configure a simple search text view
    fileprivate func configuringSearchTextField() {
        // Start visible even without user's interaction as soon as created - Default: false
        stockSearch.startVisibleWithoutInteraction = true
        
        // Set data source
        let stockSearchData = stockDataToSearch()
        stockSearch.filterStrings(stockSearchData)
    }
    
    
    // Hide keyboard when touching the screen
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    //Data Sources
    fileprivate func stockDataToSearch() -> [String] {
        var companyNames = [String]()
        for names in searchableStockData {
            companyNames.append(names.companyName!)
        }
        return companyNames
    }
    
    

}


