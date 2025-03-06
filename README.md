# Hyacinth

![Hyacinth, watercolor, pencil drawing](Resources/header.jpg)

This repository contains a collection of macros designed to enhance productivity and safety in Xcode development. Currently, it features the `#URL` macro, which provides a safer alternative to URL creation by validating URLs at compile time.

## Features

- **`#URL` Macro**: A safer way to create URLs from string literals, ensuring validity at compile time.

### `#URL` Macro

The `#URL` macro offers a secure method to create URLs from string literals. It checks the validity of the URL at compile time, preventing runtime errors due to malformed URLs.

#### Usage

To use the `#URL` macro, import the `Hyacinth` module in your Swift file:

```swift
import Hyacinth
```

Then, you can create URLs safely:

```swift
let url = #URL("https://example.com")
```

This is equivalent to:

```swift
let url = URL(string: "https://example.com")!
```

However, the `#URL` macro ensures that the URL is valid at compile time, providing an additional layer of safety.

## Getting Started

To get started with these macros, follow the instructions below:

1. **Clone the Repository**: Clone this repository to your local machine.
2. **Integrate with Xcode**: Follow the integration steps to use these macros in your Xcode project. When you first use the macros, Xcode will show a dialog:

   ```
   "HyacinthMacros" must be enabled before it can be used. Enable it now?
   ```

   You are advised to read the macro code before pressing the "Trust & Enable" button. For more details, see the screenshot below:
   
   <img src="Resources/xcode-macro-safety-request.png" alt="How to enable Xcode Macro" width="300"/>

3. **Start Using Macros**: Use the `#URL` macro in your code to ensure safe URL creation.

## Running on CI

To enable the macros on CI add the following line to your build steps:

```sh
defaults write com.apple.dt.Xcode IDESkipMacroFingerprintValidation -bool YES
```

### Xcode Cloud

For Xcode cloud this line could be added to file `ci_scripts/ci_post_clone.sh`

## License

This project is licensed under the MIT License. See the [LICENSE file](LICENSE) for details.

---
