//
//  DetailStockHistroyGraphViewController.swift
//  StockFusion
//
//  Created by Landry Achia Ndong on 2018-07-24.
//  Copyright © 2018 Landry Achia Ndong. All rights reserved.
//

import UIKit
import ScrollableGraphView

class DetailStockHistroyGraphViewController: UIViewController, ScrollableGraphViewDataSource {
    
    //var to hold reload label
    var reloadLabel = UILabel()
    
    //var to hold graphView
    var graphView: ScrollableGraphView!
    
    //var to hold constraints of graphview
    var graphConstraints = [NSLayoutConstraint]()
    
    
    //Graph button outlet to take us to Graphs
    
    
    
    //variable will hold data for the graph history when detail page is opened
    var detailStockObject = [StockHistoryModel]()
    
    
    //var number of data items
    lazy var numberOfDataItems = 60
    
    //graph Data to be ploted
    lazy var blueLinePlotDataOpenPrice: [Double] = self.dataOpenPriceForGraph(historyModel: self.detailStockObject, numberOfOpenPriceToDisplay: self.detailStockObject.count)
    
    lazy var orangeLinePlotDataClosePrice: [Double] = self.dataClosePriceForGraph(historyModel: self.detailStockObject, numberOfClosePriceToDisplay: self.detailStockObject.count)
    
    lazy var redLinePlotDataLowPrice: [Double] = self.dataLowPriceForGraph(historyModel: self.detailStockObject, numberOfClosePriceToDisplay: self.detailStockObject.count)
    
    //Label for the x-axis
    lazy var xAxisLabels: [String] = self.generateSequentialLabels(self.detailStockObject.count, text: "Day")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Graph History"
        graphView = createMultiPlotGraph(self.view.frame)
        self.view.insertSubview(graphView, belowSubview: reloadLabel)
    }
    
    
    private func addReloadLabel(withText text: String) {
        
        reloadLabel.removeFromSuperview()
        reloadLabel = createLabel(withText: text)
        reloadLabel.isUserInteractionEnabled = true
        
        let leftConstraint = NSLayoutConstraint(item: reloadLabel, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.left, multiplier: 1, constant: 20)
        
        let topConstraint = NSLayoutConstraint(item: reloadLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 20)
        
        let heightConstraint = NSLayoutConstraint(item: reloadLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 40)
        let widthConstraint = NSLayoutConstraint(item: reloadLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: reloadLabel.frame.width * 1.5)
        
       
        
        self.view.insertSubview(reloadLabel, aboveSubview: graphView)
        self.view.addConstraints([leftConstraint, topConstraint, heightConstraint, widthConstraint])
    }
    
    private func createLabel(withText text: String) -> UILabel {
        let label = UILabel()
        
        label.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        label.text = text
        label.textColor = UIColor.white
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.boldSystemFont(ofSize: 14)
        
        label.layer.cornerRadius = 2
        label.clipsToBounds = true
        
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        
        return label
    }
    
    
    
    
    // Implementation for ScrollableGraphViewDataSource protocol
    // #########################################################
    
    func value(forPlot plot: Plot, atIndex pointIndex: Int) -> Double {
        // Return the data for each plot.
        switch(plot.identifier) {
        case "multiBlue":
            return blueLinePlotDataOpenPrice[pointIndex]
        case "multiOrange":
            return orangeLinePlotDataClosePrice[pointIndex]
        case "multiRed":
            return redLinePlotDataLowPrice[pointIndex]
        default:
            return 0
        }
    }

    func label(atIndex pointIndex: Int) -> String {
        return xAxisLabels[pointIndex]
    }

    func numberOfPoints() -> Int {
        return detailStockObject.count
    }
    
    
    
    //MARK: Helper methods to handle display of graph
    
    //function will plot the grapht
    fileprivate func createMultiPlotGraph(_ frame: CGRect) -> ScrollableGraphView{
        let graphView = ScrollableGraphView(frame: frame, dataSource: self)
        
        // Setup the plot for price Open.
        let blueLinePlot = LinePlot(identifier: "multiBlue")
        
        blueLinePlot.lineWidth = 2
        blueLinePlot.lineColor = UIColor.colorFromHex(hexString: "#16aafc")
        blueLinePlot.lineStyle = ScrollableGraphViewLineStyle.smooth
        
        blueLinePlot.shouldFill = true
        blueLinePlot.fillType = ScrollableGraphViewFillType.solid
        blueLinePlot.fillColor = UIColor.colorFromHex(hexString: "#16aafc").withAlphaComponent(0.5)
        
        blueLinePlot.adaptAnimationType = ScrollableGraphViewAnimationType.elastic
        
        // Setup the second line plot for price Close.
        let orangeLinePlot = LinePlot(identifier: "multiOrange")
        
        orangeLinePlot.lineWidth = 2
        orangeLinePlot.lineColor = UIColor.colorFromHex(hexString: "#777777")
        orangeLinePlot.lineStyle = ScrollableGraphViewLineStyle.smooth
        
        orangeLinePlot.shouldFill = true
        orangeLinePlot.fillType = ScrollableGraphViewFillType.solid
        orangeLinePlot.fillGradientType = ScrollableGraphViewGradientType.linear
        orangeLinePlot.fillColor = UIColor.colorFromHex(hexString: "#555555")
        orangeLinePlot.fillGradientEndColor = UIColor.colorFromHex(hexString: "#444444")
        
        orangeLinePlot.adaptAnimationType = ScrollableGraphViewAnimationType.elastic
        
        // Setup the second line plot for price Low.
        let redLinePLot = LinePlot(identifier: "multiRed")
        
        redLinePLot.lineWidth = 2
        redLinePLot.lineColor = UIColor.colorFromHex(hexString: "#f7072f")
        redLinePLot.lineStyle = ScrollableGraphViewLineStyle.smooth
        
        redLinePLot.shouldFill = true
        redLinePLot.fillType = ScrollableGraphViewFillType.solid
        redLinePLot.fillColor = UIColor.colorFromHex(hexString: "#f7072f").withAlphaComponent(0.5)
        
        redLinePLot.adaptAnimationType = ScrollableGraphViewAnimationType.elastic
        
        
        
        
        
        // Setup the reference lines.
        let referenceLines = ReferenceLines()
        
        referenceLines.referenceLineLabelFont = UIFont.boldSystemFont(ofSize: 8)
        referenceLines.referenceLineColor = UIColor.white.withAlphaComponent(0.5)
        referenceLines.referenceLineLabelColor = UIColor.white
        
        
        referenceLines.positionType = .absolute
        
        //reference Lines will be shown at these values on the y-axis
        referenceLines.absolutePositions = [150,200,250,300,350,400,450,500,550,600,650,700]
        referenceLines.includeMinMax = true
        
        referenceLines.dataPointLabelColor = UIColor.white.withAlphaComponent(1)
        
        // Setup the graph
        graphView.backgroundFillColor = UIColor.colorFromHex(hexString: "#333333")
        
        graphView.dataPointSpacing = 45
        graphView.rangeMax = 500
        graphView.rangeMin = 50
        graphView.shouldAnimateOnStartup = true
        graphView.shouldAdaptRange = true
        
        graphView.shouldRangeAlwaysStartAtZero = false
        
        // Add everything to the graph.
        graphView.addReferenceLines(referenceLines: referenceLines)
        graphView.addPlot(plot: blueLinePlot)
        graphView.addPlot(plot: orangeLinePlot)
        graphView.addPlot(plot: redLinePLot)
        
        return graphView
    }
    
    //function to generate text label for x axis
    private func generateSequentialLabels(_ numberOfItems: Int, text: String) -> [String] {
        var labels = [String]()
        
        for i in 0 ..< detailStockObject.count{
            labels.append("\(text) \(i+1)")
        }
        return labels
    }
    
    //Mark: function to generate data for Open Price graphs
    private func dataOpenPriceForGraph(historyModel: [StockHistoryModel], numberOfOpenPriceToDisplay: Int) -> [Double] {
        var data = [Double]()
        for openData in 0 ..< detailStockObject.count{
            if let priceOpen = historyModel[openData].historyOpenPrice?.toDouble(){
                data.append(priceOpen)
            }
        }
        
        return data
    }
    
    //Mark: function to generate data for Close Price graphs
    private func dataClosePriceForGraph(historyModel: [StockHistoryModel], numberOfClosePriceToDisplay: Int) -> [Double] {
        var data = [Double]()
        for openData in 0 ..< detailStockObject.count{
            if let priceClose = historyModel[openData].historyClosePrice?.toDouble(){
                data.append(priceClose)
            }
        }
        
        return data
    }
    
    //Mark: function to generate data for Low Price graphs
    private func dataLowPriceForGraph(historyModel: [StockHistoryModel], numberOfClosePriceToDisplay: Int) -> [Double] {
        var data = [Double]()
        for openData in 0 ..< detailStockObject.count{
            if let priceLow = historyModel[openData].historyLowPrice?.toDouble(){
                data.append(priceLow)
            }
        }
        
        return data
    }
    
    
    // Constraints Function
    // ################################
    
    private func setupConstraints() {
        
        self.graphView.translatesAutoresizingMaskIntoConstraints = false
        graphConstraints.removeAll()
        
        let topConstraint = NSLayoutConstraint(item: self.graphView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        let rightConstraint = NSLayoutConstraint(item: self.graphView, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.right, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: self.graphView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        let leftConstraint = NSLayoutConstraint(item: self.graphView, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.left, multiplier: 1, constant: 0)
        
        //let heightConstraint = NSLayoutConstraint(item: self.graphView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Height, multiplier: 1, constant: 0)
        
        graphConstraints.append(topConstraint)
        graphConstraints.append(bottomConstraint)
        graphConstraints.append(leftConstraint)
        graphConstraints.append(rightConstraint)
        
        //graphConstraints.append(heightConstraint)
        
        self.view.addConstraints(graphConstraints)
    }
    
    
    


    
    


}
//extension to handle conversion of String from api to double
extension String {
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
}
