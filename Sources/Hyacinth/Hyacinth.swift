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
@freestanding(expression)
public macro URL(_ string: String) -> URL = #externalMacro(module: "HyacinthMacros", type: "URLMacro")
