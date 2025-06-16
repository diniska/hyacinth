import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

// Macro implementations build for the host, so the corresponding module is not available when cross-compiling. Cross-compiled tests may still make use of the macro itself in end-to-end tests.
#if canImport(HyacinthMacros)
import HyacinthMacros

let testMacros: [String: Macro.Type] = [
    "URL": URLMacro.self,
]
#endif

final class HyacinthTests: XCTestCase {
    func testMacroWithStringLiteral() throws {
        #if canImport(HyacinthMacros)
        assertMacroExpansion(
            """
            #URL("http://example.com")
            """,
            expandedSource: """
            URL(string: "http://example.com")!
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    
    func testEnvironmentKeyMacro() throws {
        #if canImport(HyacinthMacros)
        assertMacroExpansion(
            """
            extension EnvironmentValues {
                @EnvironmentKey
                var value: Int = -1
            }
            """,
            expandedSource: """
            extension EnvironmentValues {
                var value: Int {
                    get {
                        self [EnvironmentKey_value.self]
                    }
                    set {
                        self [EnvironmentKey_value.self] = newValue
                    }
                }
            
                private struct EnvironmentKey_value: EnvironmentKey {
                    static let defaultValue: Int = -1
                }
            }
            """,
            macros: [
                "EnvironmentKey": SwiftUIEnvironmentKeyMacro.self
            ]
        )
        
        assertMacroExpansion(
            """
            extension EnvironmentValues {
                @EnvironmentKey
                var value: Int?
            }
            """,
            expandedSource: """
            extension EnvironmentValues {
                var value: Int? {
                    get {
                        self [EnvironmentKey_value.self]
                    }
                    set {
                        self [EnvironmentKey_value.self] = newValue
                    }
                }
            
                private struct EnvironmentKey_value: EnvironmentKey {
                    static let defaultValue: Int? = nil
                }
            }
            """,
            macros: [
                "EnvironmentKey": SwiftUIEnvironmentKeyMacro.self
            ]
        )
        
        assertMacroExpansion(
            """
            extension EnvironmentValues {
                @EnvironmentKey
                var value: Int? = -1
            }
            """,
            expandedSource: """
            extension EnvironmentValues {
                var value: Int? {
                    get {
                        self [EnvironmentKey_value.self]
                    }
                    set {
                        self [EnvironmentKey_value.self] = newValue
                    }
                }
            
                private struct EnvironmentKey_value: EnvironmentKey {
                    static let defaultValue: Int? = -1
                }
            }
            """,
            macros: [
                "EnvironmentKey": SwiftUIEnvironmentKeyMacro.self
            ]
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
}
