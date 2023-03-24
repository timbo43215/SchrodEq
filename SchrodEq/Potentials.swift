//
//  Potentials.swift
//  SchrodEq
//
//  Created by Tim Stack IIT PHYS 440 on 3/3/23.
//

import Foundation

class Potentials: ObservableObject {
    @Published var x: [Double] = []
    @Published var Potential: [Double] = []
    
    func calculateInfiniteSquareWell(xmin: Double, xmax: Double, step: Double) {
        
        x.removeAll()
        Potential.removeAll()
        
        x.append(xmin)
        Potential.append(10238472389740.0)
        //Potential.append(10.0)
        
        for X in stride(from: xmin + step, to: xmax, by: step){
            x.append(X)
            Potential.append(0.0)
        }
        
        x.append(xmax)
        Potential.append(10238472389740.0)
        //Potential.append(10.0)
    }
    
    func calculateLinearSquareWell(xmin: Double, xmax: Double, step: Double) {
        x.removeAll()
        Potential.removeAll()
        
        x.append(xmin)
       // Potential.append(10238472389740.0)
        Potential.append(10.0)
        
        for X in stride(from: xmin + step, to: xmax - step, by: step) {

            x.append(X)
            Potential.append((X-xmin)*4.0*1.3)
            //potential.oneDPotentialYArray.append((i-xMin)*0.25)
        }
        
        x.append(xmax)
       // Potential.append(10238472389740.0)
        Potential.append(10.0)
    }
    
    func calculateParabolicWell(xmin: Double, xmax: Double, step: Double) {
        x.removeAll()
        Potential.removeAll()
        
        x.append(xmin)
        Potential.append(10238472389740.0)

        for X in stride(from: xmin + step, to: xmax - step, by: step) {
            
            x.append(X)
            Potential.append((pow((X-(xmax+xmin)/2.0), 2.0)/1.0))
            //potential.oneDPotentialYArray.append((i-xMin)*0.25)
        }
        
        x.append(xmax)
        Potential.append(10238472389740.0)
    }
    
    func calculateSquareAndLinearWell(xmin: Double, xmax: Double, step: Double) {
        x.removeAll()
        Potential.removeAll()
        
        x.append(xmin)
        Potential.append(10238472389740.0)

        for X in stride(from: xmin + step, to: (xmax+xmin)/2.0, by: step) {
            
            x.append(X)
            Potential.append(0.0)
            //potential.oneDPotentialYArray.append((i-xMin)*0.25)
        }
        for X in stride(from: (xmax+xmin)/2.0, to: xmax - step, by: step) {
            
            x.append(X)
            Potential.append(((X-(xmin+xmax)/2.0)*4.0*0.1))
            //potential.oneDPotentialYArray.append((i-xMin)*0.25)
        }
        
        x.append(xmax)
        Potential.append(10238472389740.0)
    }
    
    func calculateSquareBarrier(xmin: Double, xmax: Double, step: Double) {
        x.removeAll()
        Potential.removeAll()
        
        x.append(xmin)
        Potential.append(10238472389740.0)

        for X in stride(from: xmin + step, to: xmin + (xmax-xmin)*0.4, by: step) {
            
            x.append(X)
            Potential.append(0.0)
        }
        
        for X in stride(from: xmin + (xmax-xmin)*0.4, to: xmin + (xmax-xmin)*0.6, by: step) {
            
            x.append(X)
            Potential.append(15.000000001)
        }
        
        for X in stride(from: xmin + (xmax-xmin)*0.6, to: xmax, by: step) {
            
            x.append(X)
            Potential.append(0.0)
        }
        
        x.append(xmax)
        Potential.append(10238472389740.0)
    }
    
    func calculateTriangleBarrier(xmin: Double, xmax: Double, step: Double) {
        x.removeAll()
        Potential.removeAll()
        
        x.append(xmin)
        Potential.append(10238472389740.0)

        for X in stride(from: xmin + step, to: xmin + (xmax-xmin)*0.4, by: step) {
            
            x.append(X)
            Potential.append(0.0)
        }
        
        for X in stride(from: xmin + (xmax-xmin)*0.4, to: xmin + (xmax-xmin)*0.5, by: step) {
            
            x.append(X)
            Potential.append((abs(X-(xmin + (xmax-xmin)*0.4))*3.0))
        }
        
        for X in stride(from: xmin + (xmax-xmin)*0.5, to: xmin + (xmax-xmin)*0.6, by: step) {
            
            x.append(X)
            Potential.append((abs(X-(xmax - (xmax-xmin)*0.4))*3.0))
        }
        
        for X in stride(from: xmin + (xmax-xmin)*0.6, to: xmax, by: step) {
            
            x.append(X)
            Potential.append(0.0)
        }
        
        x.append(xmax)
        Potential.append(10238472389740.0)
    }
    
    func calculateCoupledParabolicWell(xmin: Double, xmax: Double, step: Double) {
        x.removeAll()
        Potential.removeAll()
        
        x.append(xmin)
        Potential.append(10238472389740.0)

        for X in stride(from: xmin + step, to: xmin + (xmax-xmin)*0.5, by: step) {
            
            x.append(X)
            Potential.append((pow((X-(xmin+(xmax-xmin)/4.0)), 2.0)))
        }
        
        for X in stride(from: xmin + (xmax-xmin)*0.5, through: xmax - step, by: step) {
            
            x.append(X)
            Potential.append((pow((X-(xmax-(xmax-xmin)/4.0)), 2.0)))
        }
        
        x.append(xmax)
        Potential.append(10238472389740.0)
    }
    
    func calculateCoupledSquareWellAndField(xmin: Double, xmax: Double, step: Double) {
        x.removeAll()
        Potential.removeAll()
        
        x.append(xmin)
        Potential.append(10238472389740.0)

        for X in stride(from: xmin + step, to: xmin + (xmax-xmin)*0.4, by: step) {
            
            x.append(X)
            Potential.append(0.0)
            
        }
        
        for X in stride(from: xmin + (xmax-xmin)*0.4, to: xmin + (xmax-xmin)*0.6, by: step) {
            
            x.append(X)
            Potential.append(4.0)
            
        }
        
        for X in stride(from: xmin + (xmax-xmin)*0.6, to: xmax, by: step) {
            
            x.append(X)
            Potential.append(0.0)

        }
        
        for X in 1 ..< (x.count) {
            
            Potential[X] += ((x[X]-xmin)*4.0*0.1)
        }
        
        x.append(xmax)
        Potential.append(10238472389740.0)
    }
    
    func calculateHarmonicOscillator(xmin: Double, xmax: Double, step: Double) {
        x.removeAll()
        Potential.removeAll()
        
        x.append(xmin)
        Potential.append(10238472389740.0)

        let xminHO = -20.0
        let xmaxHO = 20.0
        let stepHO = 0.001

        for X in stride(from: xminHO+stepHO, through: xmaxHO-stepHO, by: stepHO) {
            
            x.append(X+xmaxHO)
            Potential.append((pow((X-(xmaxHO+xminHO)/2.0), 2.0)/15.0))
        }
        
        x.append(xmax)
        Potential.append(10238472389740.0)
    }
    
    func calculateKronigPenney(xmin: Double, xmax: Double, step: Double) {
        x.removeAll()
        Potential.removeAll()
        
        x.append(xmin)
        Potential.append(10238472389740.0)

        let xMinKP = 0.0
        
        let xStepKP = 0.001
        let hbarc = 1973.269804
        let m = 510998.95000
        
        let hbar2overm = pow(hbarc,2)/m
        
        let numberOfBarriers = 10.0
        let boxLength = 10.0
        let barrierPotential = 100.0*hbar2overm/2.0
        let latticeSpacing = boxLength/numberOfBarriers
        let barrierWidth = 1.0/6.0*latticeSpacing
        var barrierNumber = 1;
        var currentBarrierPosition = 0.0
        var inBarrier = false;
        
        let xMaxKP = boxLength
        
        for X in stride(from: xMinKP+xStepKP, through: xMaxKP-xStepKP, by: xStepKP) {
            
            currentBarrierPosition = -latticeSpacing/2.0 + Double(barrierNumber)*latticeSpacing
            
            if( (abs(X-currentBarrierPosition)) < (barrierWidth/2.0)) {
                
                inBarrier = true
                
                //                potential.oneDPotentialArray.append((xCoord: i, Potential: barrierPotential))
                
                x.append(X)
                Potential.append(barrierPotential)
            }
            
            else {
                
                if (inBarrier){
                    
                    inBarrier = false
                    barrierNumber += 1
                }
                
                x.append(X)
                Potential.append(0.0)
            }
        }
        
        x.append(xmax)
        Potential.append(10238472389740.0)
    }
}
