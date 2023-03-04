//
//  ContentView.swift
//  SchrodEq
//
//  Created by Tim Stack IIT PHYS 440 on 2/24/23.
//

import SwiftUI

struct ContentView: View {
    @State var input1: String = ""
    @State var input2: String = ""
    @State var input3: String = ""
    @State var input4: String = ""
    @State var input5: String = ""
    @State var input6: String = ""
    @State var output1: String = ""
    @State var output2: String = ""
    @ObservedObject var myPotentials = Potentials()
    @ObservedObject var myWaveFunctions = WaveFunctions()
    @ObservedObject var myFunctionals = Functionals()
    
    var body: some View {
        VStack {
            TextField("Input 1", text: $input1)
            TextField("Input 2", text: $input2)
            TextField("Input 3", text: $input3)
            TextField("Input 4", text: $input4)
            TextField("Input 5", text: $input5)
            TextField("Input 6", text: $input6)
            
            Button(action: {
                self.calculateEigenValues()
                // Perform the calculation here
//                let result1 = // Calculation for output 1 using input1 to input6
//              let result2 = // Calculation for output 2 using input1 to input6
//                output1 = "\(result1)"
//                output2 = "\(result2)"
            }) {
                Text("Calculate")
            }
            
            TextField("Output 1", text: $output1)
            TextField("Output 2", text: $output2)
        }
    }
    func calculateEigenValues(){
        let Emin = 0.0
        let Emax = 30.0
        let xmin = 0.0
        let xmax = 10.0
        let step = 0.05
// hbarc in eV*Angstroms
        let hbarc = 1973.269804
// mass of electron in eVc^2
        let m = 510998.95000
        
        myPotentials.calculateInfiniteSquareWell(xmin: xmin, xmax: xmax, step: step)
        let SchrodingerConstant = -((2.0 * m)/pow(hbarc,2.0))
        
        for Energy in stride(from: Emin, through: Emax, by: step) {
//clear all arrays
            myWaveFunctions.psi = []
            myWaveFunctions.psiPrime = []
            myWaveFunctions.psiDoublePrime = []
            myWaveFunctions.x = []
// Guess psi prime
            myWaveFunctions.psiPrime.append(1.0)
            myWaveFunctions.psi.append(0.0)
            myWaveFunctions.x.append(xmin)
            myWaveFunctions.psiDoublePrime.append(SchrodingerConstant * myWaveFunctions.psi[0] * (Energy - myPotentials.Potential[0]))
            
            for n in 1...(Int((xmax - xmin)/step) + 1){
//            for X in stride(from: xmin, through: xmax, by: step){
                let x = (Double(n) * step) + xmin
                let psiDoublePrime = SchrodingerConstant * myWaveFunctions.psi[n-1] * (Energy - myPotentials.Potential[n-1])
                let psiPrime = myWaveFunctions.psiPrime[n-1] + (myWaveFunctions.psiDoublePrime[n-1] * step)
                let psi = myWaveFunctions.psi[n-1] + (myWaveFunctions.psiPrime[n-1] * step)
                
                myWaveFunctions.psiPrime.append(psiPrime)
                myWaveFunctions.psi.append(psi)
                myWaveFunctions.x.append(x)
                myWaveFunctions.psiDoublePrime.append(psiDoublePrime)
            }
            myFunctionals.Energy.append(Energy)
            let points = myWaveFunctions.psi.count
// Actually - 0.0 because psi(L) = 0 but why do extra math?
            let functionalValue = myWaveFunctions.psi[points-1]
            myFunctionals.Functional.append(functionalValue)
        }
        let Points = myFunctionals.Energy.count
        for i in 0...(Points - 1) {
            print(myFunctionals.Energy[i], myFunctionals.Functional[i])
        }
        print(-pow(Double.pi,2)/(SchrodingerConstant * pow(xmin - xmax, 2)))
    }
}

struct CalculationView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
