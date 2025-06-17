//
//  SwiftUIEnvironmentMacro.swift
//  Hyacinth
//
//  Created by Denis Chaschin on 15/6/2025.
//

import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros


/// A macro for defining custom SwiftUI environment keys and storage.
///
/// Use the `@EnvironmentKey` macro to easily create a new `EnvironmentKey` and
/// provide storage for its value. This macro generates the necessary key struct
/// and accessors for use with SwiftUI's environment system.
///
/// ### Example
/// ```swift
/// extension EnvironmentValues {
///     @EnvironmentKey
///     var value: Int = 1
/// }
/// ```
///
/// This will generate:
/// - An `EnvironmentKey_value` struct conforming to `EnvironmentKey`
/// - Storage and accessors for `value`
///
/// You can then use `value` with SwiftUI's `@Environment` property wrapper.
///
/// - Note: The macro must be applied to a variable inside `EnvironmentValues`.
public struct SwiftUIEnvironmentKeyMacro {}

extension SwiftUIEnvironmentKeyMacro: PeerMacro {
    public static func expansion(of node: AttributeSyntax, providingPeersOf declaration: some DeclSyntaxProtocol, in context: some MacroExpansionContext) throws -> [DeclSyntax] {
        
        guard
            let variableDeclaration = declaration.as(VariableDeclSyntax.self),
            var binding = variableDeclaration.bindings.first
        else { return [] }
        
        guard let identifier = binding.pattern.as(IdentifierPatternSyntax.self)?.identifier.trimmed
        else { return [] }
        
        binding.pattern = PatternSyntax(IdentifierPatternSyntax(identifier: .identifier("defaultValue")))
        
        if binding.typeAnnotation?.type.is(OptionalTypeSyntax.self) == true,
           binding.initializer == nil {
            binding.initializer = InitializerClauseSyntax(value: NilLiteralExprSyntax())
        }
        
        return [
            """
            private struct EnvironmentKey_\(identifier): EnvironmentKey {
                static let \(binding)
            }
            """
        ]
    }
}

extension SwiftUIEnvironmentKeyMacro: AccessorMacro {
    public static func expansion(of node: AttributeSyntax, providingAccessorsOf declaration: some DeclSyntaxProtocol, in context: some MacroExpansionContext) throws -> [AccessorDeclSyntax] {
        
        guard
            let variableDeclaration = declaration.as(VariableDeclSyntax.self),
            let binding = variableDeclaration.bindings.first
        else { return [] }
        
        if binding.typeAnnotation?.type.is(OptionalTypeSyntax.self) == false,
           binding.initializer == nil {
            throw HyacinthError.initialValueIsMissing(diagnostic: "@EnvironmentKey macro requires an initial value for not optional types")
        }

        guard let identifier = variableDeclaration.bindings.first?.pattern.as(IdentifierPatternSyntax.self)?.identifier.trimmed
        else { return [] }
        
        return [
            "get { self[EnvironmentKey_\(identifier).self] }",
            "set { self[EnvironmentKey_\(identifier).self] = newValue }",
        ]
    }
}
