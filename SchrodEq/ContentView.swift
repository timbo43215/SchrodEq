//
//  ContentView.swift
//  SchrodEq
//
//  Created by Tim Stack IIT PHYS 440 on 2/24/23.
//

import SwiftUI
import Charts

struct ContentView: View {
    @EnvironmentObject var plotData :PlotClass
    @State var xmin: String = "0.0"
    @State var xmax: String = "10.0"
    @State var step: String = "0.05"
    @State var emin: String = "0.0"
    @State var emax: String = "30.0"
    @State var estep: String = "0.05"
    @State var eigenValues: String = ""
    @State var output2: String = ""
    @ObservedObject var myPotentials = Potentials()
    @ObservedObject var myWaveFunctions = WaveFunctions()
    @ObservedObject var myFunctionals = Functionals()
    @ObservedObject var myRootFinder = RootFinder()
    @ObservedObject var myCalculatePlotData = CalculatePlotData()
    @State var selectedFunctionIndex = 670
    @State var selectedGraphIndex = 670
    @State var selector = 0
    @State var potentialStringArray = ["Infinite Square Well", "Linear Square Well","Parabolic Well","Square and Linear Well","Square Barrier","Triangle Barrier","Coupled Parabolic Well","Coupled Square Well and Field","Harmonic Oscillator","Kronig Penney"]
    
    var body: some View {
        HStack{
            VStack {
                TextField("Xmin:", text: $xmin)
                TextField("Xmax:", text: $xmax)
                TextField("Step:", text: $step)
                TextField("Energy min", text: $emin)
                TextField("Energy max", text: $emax)
                TextField("Energy step", text: $estep)
                TextField("Energies:", text: $eigenValues)
                TextField("Output 2", text: $output2)
                
                Picker("Select Graph Type", selection: $selectedGraphIndex) {
                    Text("Potential").tag(0)
                    Text("Functional").tag(1)
                    Text("Wave Function").tag(2)
                }
                .padding(.horizontal)
                .onChange(of: selectedGraphIndex) { _ in
                    switch selectedGraphIndex {
                    case 0:
                        myCalculatePlotData.plotPotential()
                    case 1:
                        myCalculatePlotData.plotFunctional()
                    case 2:
                        myPotentials.calculateWaveFunction()
                    default:
                        break
                    }
                    
                    Picker("Select Function", selection: $selectedFunctionIndex) {
                        Text("Infinite Square Well").tag(0)
                        Text("Linear Square Well").tag(1)
                        Text("Parabolic Well").tag(2)
                        Text("Square and Linear Well").tag(3)
                        Text("Square Barrier").tag(4)
                        Text("Triangle Barrier").tag(5)
                        Text("Coupled Parabolic Well").tag(6)
                        Text("Coupled Square Well and Field").tag(7)
                        Text("Harmonic Oscillator").tag(8)
                        Text("Kronig Penney").tag(9)
                    }
                    //.pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                    .onChange(of: selectedFunctionIndex)  { _ in
                        switch selectedFunctionIndex {
                        case 0:
                            myPotentials.calculateInfiniteSquareWell(xmin: Double(xmin)!, xmax: Double(xmax)!, step: Double(step)!)
                        case 1:
                            myPotentials.calculateLinearSquareWell(xmin: Double(xmin)!, xmax: Double(xmax)!, step: Double(step)!)
                        case 2:
                            myPotentials.calculateParabolicWell(xmin: Double(xmin)!, xmax: Double(xmax)!, step: Double(step)!)
                        case 3:
                            myPotentials.calculateSquareAndLinearWell(xmin: Double(xmin)!, xmax: Double(xmax)!, step: Double(step)!)
                        case 4:
                            myPotentials.calculateSquareBarrier(xmin: Double(xmin)!, xmax: Double(xmax)!, step: Double(step)!)
                        case 5:
                            myPotentials.calculateTriangleBarrier(xmin: Double(xmin)!, xmax: Double(xmax)!, step: Double(step)!)
                        case 6:
                            myPotentials.calculateCoupledParabolicWell(xmin: Double(xmin)!, xmax: Double(xmax)!, step: Double(step)!)
                        case 7:
                            myPotentials.calculateCoupledSquareWellAndField(xmin: Double(xmin)!, xmax: Double(xmax)!, step: Double(step)!)
                        case 8:
                            myPotentials.calculateHarmonicOscillator(xmin: Double(xmin)!, xmax: Double(xmax)!, step: Double(step)!)
                        case 9:
                            myPotentials.calculateKronigPenney(xmin: Double(xmin)!, xmax: Double(xmax)!, step: Double(step)!)
                        default:
                            break
                        }
                    }
                    
                    Button(action: {
                        self.calculateEigenValues()
                    }) {
                        Text("Calculate Eigen Values")
                    }
                    
                }
                
                VStack{
                    Group{
                        HStack(alignment: .center, spacing: 0) {
                            //Text("Height (cm)")
                            Text($plotData.plotArray[selector].changingPlotParameters.yLabel.wrappedValue)
                                .rotationEffect(Angle(degrees: -90))
                                .foregroundColor(.black)
                                .padding()
                            VStack {
                                Chart($plotData.plotArray[selector].plotData.wrappedValue) {
                                    LineMark(
                                        x: .value("Position", $0.xVal),
                                        y: .value("Height", $0.yVal)
                                        
                                    )
                                    .foregroundStyle($plotData.plotArray[selector].changingPlotParameters.lineColor.wrappedValue)
                                    PointMark(x: .value("Position", $0.xVal), y: .value("Height", $0.yVal))
                                    
                                        .foregroundStyle($plotData.plotArray[selector].changingPlotParameters.lineColor.wrappedValue)
                                    
                                    
                                }
                                .chartYAxis {
                                    AxisMarks(position: .leading)
                                }
                                .padding()
                                Text($plotData.plotArray[selector].changingPlotParameters.xLabel.wrappedValue)
                                    .foregroundColor(.black)
                            }
                        }
                        // .frame(width: 350, height: 400, alignment: .center)
                        .frame(alignment: .center)
                        
                    }
                    .padding()
                }
                
            }
            
            
        }
    }
    func calculateWaveFunction(_ Energy: Double, _ SchrodingerConstant: Double, _ xmin: Double, _ xmax: Double, _ step: Double) -> Double {
        

        
        
        // Guess psi prime
        
        //Clear All Arrays
        myWaveFunctions.psi = []
        myWaveFunctions.psiPrime = []
        myWaveFunctions.psiDoublePrime = []
        myWaveFunctions.x = []
        
        myWaveFunctions.psiPrime.append(1.0)
        myWaveFunctions.psi.append(0.0)
        myWaveFunctions.x.append(xmin)
        myWaveFunctions.psiDoublePrime.append(SchrodingerConstant * myWaveFunctions.psi[0] * (Energy - myPotentials.Potential[0]))
        
        for n in 1..<(Int((xmax - xmin)/step) + 1) {
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
        let count = myWaveFunctions.psi.count
 //       print(Energy, myWaveFunctions.psi[count-1])
        
        
        return myWaveFunctions.psi[count-1]
    }
    
    func calculateEigenValues() {
        let Emin = Double(emin)!
        let Emax = Double(emax)!
        let xmin = Double(xmin)!
        let xmax = Double(xmax)!
        let xstep = Double(step)!
        let Estep = Double(estep)!
// hbarc in eV*Angstroms
        let hbarc = 1973.269804
// mass of electron in eVc^2
        let m = 510998.95000
        
        myFunctionals.Energy = []
        myFunctionals.Functional = []
        
        let SchrodingerConstant = -((2.0 * m)/pow(hbarc,2.0))
        
        plotData.plotArray[0].calculatedText = "Energy Eigenvalues for \(potentialStringArray[selectedFunctionIndex])\n"
        
        for Energy in stride(from: Emin, through: Emax, by: Estep) {

            
            let _ = calculateWaveFunction(Energy, SchrodingerConstant, xmin, xmax, xstep)
            myFunctionals.Energy.append(Energy)
            let points = myWaveFunctions.psi.count
// Actually - 0.0 because psi(L) = 0 but why do extra math?
            let functionalValue = myWaveFunctions.psi[points-1]
            myFunctionals.Functional.append(functionalValue)
        }
//        let Points = myFunctionals.Energy.count
//        for i in 0...(Points - 1) {
//            print(myFunctionals.Energy[i], myFunctionals.Functional[i])
//        }
        
// Find the roots of the functional
       // do something here (probably going to call rootFinder function
        var FunctionalForRootFinding : [[Double]] = []
        for i in 0..<myFunctionals.Energy.count {
           FunctionalForRootFinding.append([myFunctionals.Energy[i],myFunctionals.Functional[i]])
        }
        
        let Energies = myRootFinder.rootFinder(functionData: FunctionalForRootFinding, h: 1e-5, xstep: xstep, function: calculateWaveFunction, SchrodingerConstant: SchrodingerConstant, xmin: xmin, xmax: xmax, Estep: Estep)
        
        print(Energies)
        
        for item in Energies{
            plotData.plotArray[0].calculatedText += String(format: "%0.3f\n", item)
        }
        myCalculatePlotData.plotDataModel = self.plotData.plotArray[0]
        
        myCalculatePlotData.plotPotential()
        //print(-pow(Double.pi,2)/(SchrodingerConstant * pow(xmin - xmax, 2)))
        
    }
    
}

struct CalculationView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
