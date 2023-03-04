//
//  WaveFunction.swift
//  SchrodEq
//
//  Created by Tim Stack IIT PHYS 440 on 3/3/23.
//

import Foundation

class WaveFunctions: ObservableObject {
    @Published var x: [Double] = []
    @Published var psi: [Double] = []
    @Published var psiPrime: [Double] = []
    @Published var psiDoublePrime: [Double] = []

}
