//
//  URLMacro.swift
//
//
//  Created by Denis Chaschin on 19/9/2023.
//

import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import Foundation

/// A safer alternative to `URL` creation that produces a `URL` from a string literal.
/// For example,
/// ```
/// let url = #URL("https://example.com")
/// ```
/// is equivalent to
/// ```
/// let url = URL(string: "https://example.com")!
/// ```
/// but is checked at compile time to be a valid URL.
public struct URLMacro: ExpressionMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) throws -> ExprSyntax {
        
        guard
            let argument = node.arguments.first?.expression
        else {
            fatalError("compiler bug: the macro does not have any arguments")
        }
        
        guard
            let segments = argument.as(StringLiteralExprSyntax.self)?.segments,
            segments.count == 1,
            case .stringSegment(let literalSegment)? = segments.first
        else {
            throw HyacinthError.malformedUrlLiteral(url: argument.description)
        }
        
        let text = literalSegment.content.text
        
        guard URL(string: text) != nil
        else {
            throw HyacinthError.malformedUrl(url: text)
        }
        
        return "URL(string: \(argument))!"
    }
}

