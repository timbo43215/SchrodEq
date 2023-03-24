//
//  CalculatePlotData.swift
//  Test Plot Threaded Charts
//
//  Created by Jeff Terry on 8/25/22.
//

import Foundation
import SwiftUI


class CalculatePlotData: ObservableObject {
    
    var plotDataModel: PlotDataClass? = nil
    var theText = ""
    var potentialStringArray = ["Infinite Square Well", "Linear Square Well","Parabolic Well","Square and Linear Well","Square Barrier","Triangle Barrier","Coupled Parabolic Well","Coupled Square Well and Field","Harmonic Oscillator","Kronig Penney"]

    @MainActor func setThePlotParameters(color: String, xLabel: String, yLabel: String, title: String) {
        //set the Plot Parameters
        plotDataModel!.changingPlotParameters.yMax = 10.0
        plotDataModel!.changingPlotParameters.yMin = -5.0
        plotDataModel!.changingPlotParameters.xMax = 10.0
        plotDataModel!.changingPlotParameters.xMin = -5.0
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
    
    @MainActor func appendDataToPlot(plotData: [(x: Double, y: Double)]) {
        plotDataModel!.appendData(dataPoint: plotData)
    }
    
    @MainActor func plotPotential()
    {
        
        theText = "\(potentialStringArray[selectedFunctionIndex])n"
        
         setThePlotParameters(color: "Blue", xLabel: "x", yLabel: "Potential", title: "\(potentialStringArray[selectedFunctionIndex])")
        
        resetCalculatedTextOnMainThread()
        
        
        var plotData :[(x: Double, y: Double)] =  []
        
        
        for i in 0 ..< 40 {
             
            //create x values here
            let x = -2.0 + Double(i) * 0.6

        //create y values here
        let y = x


            let dataPoint: (x: Double, y: Double) = (x: x, y: y)
            plotData.append(contentsOf: [dataPoint])
            theText += "x = \(x), y = \(y)\n"
        
        }
        
        appendDataToPlot(plotData: plotData)
        updateCalculatedTextOnMainThread(theText: theText)
        
        
    }
    
    
    func ploteFunctional() async
    {
        
        //set the Plot Parameters
        
        await setThePlotParameters(color: "Blue", xLabel: "x", yLabel: "y = exp(-x)", title: "y = exp(-x)")
        
        await resetCalculatedTextOnMainThread()
        
        theText = "y = exp(-x)\n"
        
        var plotData :[(x: Double, y: Double)] =  []
        for i in 0 ..< 60 {

            //create x values here
            let x = -2.0 + Double(i) * 0.2

        //create y values here
        let y = exp(-x)
            
            let dataPoint: (x: Double, y: Double) = (x: x, y: y)
            plotData.append(contentsOf: [dataPoint])
            theText += "x = \(x), y = \(y)\n"
        }
        
        await appendDataToPlot(plotData: plotData)
        await updateCalculatedTextOnMainThread(theText: theText)
        
        return
    }
    
    
        @MainActor func resetCalculatedTextOnMainThread() {
            //Print Header
            plotDataModel!.calculatedText = ""
    
        }
    
    
        @MainActor func updateCalculatedTextOnMainThread(theText: String) {
            //Print Header
            plotDataModel!.calculatedText += theText
        }
    
    @MainActor func plotWaveFunction()
    {
        
        theText = "\(potentialStringArray[selectedFunctionIndex])n"
        
         setThePlotParameters(color: "Blue", xLabel: "x", yLabel: "Potential", title: "\(potentialStringArray[selectedFunctionIndex])")
        
        resetCalculatedTextOnMainThread()
        
        
        var plotData :[(x: Double, y: Double)] =  []
        
        
        for i in 0 ..< 40 {
             
            //create x values here
            let x = -2.0 + Double(i) * 0.6

        //create y values here
        let y = x


            let dataPoint: (x: Double, y: Double) = (x: x, y: y)
            plotData.append(contentsOf: [dataPoint])
            theText += "x = \(x), y = \(y)\n"
        
        }
        
        appendDataToPlot(plotData: plotData)
        updateCalculatedTextOnMainThread(theText: theText)
        
        
    }
    
}
