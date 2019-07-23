//
//  Kitties.swift
//  KittyChallenge
//
//  Created by Jeff Tabios on 22/07/2019.
//  Copyright © 2019 Jeff Tabios. All rights reserved.
//

import Foundation

// MARK: - Kitty
struct Kitty: Codable {
    let height: Int
    let id: String
    let url: String
    let width: Int
}

typealias Kitties = [Kitty]
