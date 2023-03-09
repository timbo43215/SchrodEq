//
//  Ynpri.swift
//  SchrodEq
//
//  Created by IIT PHYS 440 on 2/24/23.
//

import Foundation

func Ynp1pripri(E: Double, V: Double, m: Double, h: Double) -> Double {
    return (-(2*m)/pow(h,2)) * Yn(E - V)
}
