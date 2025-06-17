//
//  HyacinthError.swift
//
//
//  Created by Denis Chaschin on 19/9/2023.
//

enum HyacinthError: Error {
    case malformedUrl(url: String)
    case malformedUrlLiteral(url: String)
    case initialValueIsMissing(diagnostic: String)
}
