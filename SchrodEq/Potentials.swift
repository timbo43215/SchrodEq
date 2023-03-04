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
        x.append(xmin)
        Potential.append(10238472389740.0)
        
        for X in stride(from: xmin + step, to: xmax, by: step){
            x.append(X)
            Potential.append(0.0)
        }
        
        x.append(xmax)
        Potential.append(10238472389740.0)
    }
}
