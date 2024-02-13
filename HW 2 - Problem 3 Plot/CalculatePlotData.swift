//
//  ContentView.swift
//  Charts Plot Observation
//
//  Created by Jeff_Terry on 1/15/24.
//  Modified by Marco Gonzalez 2/11/24
//

import Foundation
import SwiftUI
import Observation


@Observable class CalculatePlotData {
    
    var plotDataModel: PlotDataClass? = nil
    var theText = ""
    
    
    /// Set the Plot Parameters
    /// - Parameters:
    ///   - color: Color of the Plotted Data
    ///   - xLabel: x Axis Label
    ///   - yLabel: y Axis Label
    ///   - title: Title of the Plot
    ///   - xMin: Minimum value of x Axis
    ///   - xMax: Maximum value of x Axis
    ///   - yMin: Minimum value of y Axis
    ///   - yMax: Maximum value of y Axis
    @MainActor func setThePlotParameters(color: String, xLabel: String, yLabel: String, title: String, xMin: Double, xMax: Double, yMin:Double, yMax:Double) {
        //set the Plot Parameters
        plotDataModel!.changingPlotParameters.yMax = yMax
        plotDataModel!.changingPlotParameters.yMin = yMin
        plotDataModel!.changingPlotParameters.xMax = xMax
        plotDataModel!.changingPlotParameters.xMin = xMin
        plotDataModel!.changingPlotParameters.xLabel = xLabel
        plotDataModel!.changingPlotParameters.yLabel = yLabel
        
        if color == "Red"{
            plotDataModel!.changingPlotParameters.lineColor = Color.red
        }
        else{
            
            plotDataModel!.changingPlotParameters.lineColor = Color.blue
        }
        plotDataModel!.changingPlotParameters.title = title
        
        plotDataModel!.zeroData()
    }
    
    /// This appends data to be plotted to the plot array
    /// - Parameter plotData: Array of (x, y) points to be added to the plot
    @MainActor func appendDataToPlot(plotData: [(x: Double, y: Double)]) {
        plotDataModel!.appendData(dataPoint: plotData)
        
        
        
        
        
    }
    
    
    func reldiff() async {
        let N = 100 // Range of N values
        var plotData: [(x: Double, y: Double)] = []
        
        for n in 1...N {
            let sUp = (1...n).reduce(0.0) { sum, i in sum + 1.0 / Double(i) }
            let sDown = (1...n).reversed().reduce(0.0) { sum, i in sum + 1.0 / Double(i) }
            let relativeDifference = (sUp - sDown) / (abs(sUp) + abs(sDown))
            
            plotData.append((x: Double(n), y: relativeDifference))
        }
        
        await setThePlotParameters(color: "Blue", xLabel: "N", yLabel: "Relative Difference", title: "Relative Difference vs. N", xMin: 1.0, xMax: Double(N), yMin: plotData.min(by: { $0.y < $1.y })?.y ?? 0.0, yMax: plotData.max(by: { $0.y < $1.y })?.y ?? 0.0)
        
        await appendDataToPlot(plotData: plotData)
    }
    
    
    
}
