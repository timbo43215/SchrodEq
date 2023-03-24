//
//  Solutions.swift
//  SchrodEq
//
//  Created by IIT PHYS 440 on 3/24/23.
//
import SwiftUI
import Foundation

class Solutions: ObservableObject {
    
    @Published var solutionData = [(EnergyPoint: Double, xArray: [Double], psiArray:[Double])]()

}
