# Hyacinth

![Hyacinth, watercolor, pencil drawing](resources/header.jpg)

This repository contains a collection of macros designed to enhance productivity and safety in Xcode development. Currently, it features the `#URL` macro, which provides a safer alternative to URL creation by validating URLs at compile time.

## Features

- **`#URL` Macro**: A safer way to create URLs from string literals, ensuring validity at compile time.

### `#URL` Macro

The `#URL` macro offers a secure method to create URLs from string literals. It checks the validity of the URL at compile time, preventing runtime errors due to malformed URLs.

#### Usage

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

## License

This project is licensed under the MIT License. See the [LICENSE file](LICENSE) for details.

---
