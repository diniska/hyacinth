//
//  Plugin.swift
//
//
//  Created by Denis Chaschin on 19/9/2023.
//

import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct HyacinthPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        URLMacro.self,
    ]
}
