//
//  rootFinder.swift
//  SchrodEq
//
//  Created by IIT PHYS 440 on 3/8/23.
//

import Foundation

class RootFinder: ObservableObject {
    
    typealias extrapolatedDifferenceFunction = (_ Energy: Double, _ SchrodingerConstant: Double, _ xmin: Double, _ xmax: Double, _ step: Double) -> Double
    typealias rootFinderFunctionAlias = (_ Energy: Double, _ SchrodingerConstant: Double, _ xmin: Double, _ xmax: Double, _ step: Double) -> Double
    
    /// calculateExtrapolatedDifference
    ///
    /// Calculates the derivative of a function y(x) at the point x
    ///
    //
    //  Extapolated Difference Approximation of a Derivative
    //
    //
    //                        h              h               h              h
    //             8 *(y(x + ---)  -  y(x - ---))  - (y(x + ---)  -  y(x - ---))
    //  d                     4              4               2              2
    //  -- y(x) =  ----------------------------------------------------------
    //  dx                                  3h
    //
    ///
    /// - Parameters:
    ///   - functionToDifferentiate: function to be differentiated to calculate the value of y at each of the 4 points in the Extrapolated Difference method
    ///   - x: Position at which to calculate the derivative
    ///   - h: Extrapolated Difference h term
    /// - Returns: deriviative of the function
    func calculateExtrapolatedDifference(functionToDifferentiate: extrapolatedDifferenceFunction, h: Double, xstep: Double, SchrodingerConstant: Double, xmin: Double, xmax: Double, Estep: Double, Energy: Double) -> (Double) {
        
        
        var newEnergy = Energy + h/4.0
        let term1 = functionToDifferentiate((newEnergy), SchrodingerConstant, xmin, xmax, xstep)
        newEnergy = Energy - h/4.0
        let term2 = functionToDifferentiate((newEnergy), SchrodingerConstant, xmin, xmax, xstep)
        newEnergy = Energy + h/2.0
        let term3 = functionToDifferentiate((newEnergy), SchrodingerConstant, xmin, xmax, xstep)
        newEnergy = Energy - h/2.0
        let term4 = functionToDifferentiate((newEnergy), SchrodingerConstant, xmin, xmax, xstep)
        
        let extrapolatedDifferenceDerivativeNumerator = 8.0 * (term1 - term2) - (term3 - term4)
        
        let extrapolatedDifferenceDerivative = extrapolatedDifferenceDerivativeNumerator/(3.0*h)
        
    return(extrapolatedDifferenceDerivative)

    }
    
    /// rootFinder
    ///
    /// Uses the Newton-Raphson Method to find roots of an equation
    ///
    //                f(x )
    //                   0
    //  Delta x =  - ---------
    //                 df  |
    //                ---  |
    //                 dx  | x
    //                        0
    //
    ///
    /// - Parameters:
    ///   - functionData: Array of function data over which to find roots
    ///   - h: Extrapolated Difference h term
    ///   - step: step size
    ///   - function: Function used to calculate the exact values in the Extrapolated Difference
    /// - Returns: Roots of the function
    ///
    func rootFinder(functionData: [[Double]], h: Double, xstep: Double, function: rootFinderFunctionAlias, SchrodingerConstant: Double, xmin: Double, xmax: Double, Estep: Double) -> [Double]{
        
        var quickSearchResult :[Double] = []
        var finalRoots :[Double] = []
        
        var previousFunctionValue = functionData[0][1]
        
        for item in functionData{
            
            if(previousFunctionValue*item[1] <= 0){
                
                quickSearchResult.append(item[0])
            }
            
            previousFunctionValue = item[1]
            
        }
        
        
        for item in quickSearchResult{
            
            var Energy = item - 2.0*Estep
            var deltaX = 1.0
            
//            Newton-Raphson Search
            for _ in 0...20 {

                let newtonRaphsonNumerator = function(Energy, SchrodingerConstant, xmin, xmax, xstep)
 

                // Extrapolated Difference
                let newtonRaphsonDenominator = calculateExtrapolatedDifference(functionToDifferentiate: function, h: h, xstep: xstep, SchrodingerConstant: SchrodingerConstant, xmin: xmin, xmax: xmax, Estep: Estep, Energy: Energy)

                deltaX = -newtonRaphsonNumerator/newtonRaphsonDenominator

                Energy = Energy + deltaX

                if abs(deltaX) <= (Energy.ulp*10.0) {
                    print("break")
                    break

                }

            }
            
            finalRoots.append(Energy)
           // print(Energy, deltaX)
            
        }
        
        return(finalRoots)
        
    }
}
