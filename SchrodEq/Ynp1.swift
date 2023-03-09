//
//  Yn.swift
//  SchrodEq
//
//  Created by IIT PHYS 440 on 2/24/23.
//

import Foundation

func Ynp1(Yn: Double, Ynpri: Double, Dx: Double) -> Double {
    return Yn + (Ynpri * Dx)
}
