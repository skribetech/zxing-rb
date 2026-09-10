# Zxing-C++ Ruby Wrapper

Ruby wrapper for [zxing-cpp](https://github.com/zxing-cpp/zxing-cpp) to read DataMatrix and QR codes from images.

## Features

- Simple API: `Zxing.read_datamatrix(path)` and `Zxing.read_qrcode(path)` → String or nil
- Reads DataMatrix and QR codes from JPEG, PNG, BMP, and other image formats

## Requirements

### System Requirements

- **C++ Compiler**: C++20 support required
- **ZXing-CPP**: System-installed library (libzxing-dev); verified with version 2.2.1
- **Build Tools**: build-essential, ruby-dev

### Installation

First install the dependencies.
On Ubuntu:

```bash
sudo apt-get install build-essential ruby-dev libzxing-dev
```
On macOS:

```bash
xcode-select --install
brew tap skribetech/zxing-cpp
brew install zxing-cpp
```

Then compile the extension:

```bash
bundle install
bundle exec rake compile
```

## Usage

```ruby
require 'zxing'

Zxing.read_qrcode('qr.png')       # => "https://example.com/qr?value=42"
Zxing.read_datamatrix('dm.png')   # => decoded text
```

Each method returns the first valid code of its requested format as a String,
or `nil` when the image contains no matching code. Missing, unreadable, or invalid
image files raise `RuntimeError` with a message beginning with `Failed to load image`.
Both readers try rotated and downscaled images.

QR codes return plain decoded text, including Unicode. DataMatrix retains its
existing human-readable interpretation (HRI). These methods return text, not raw
binary payloads, and do not return multiple codes or position metadata.

## Development

```bash
bundle exec rake
```

This compiles the native extension and runs the DataMatrix and QR regression tests.
The extension and test suite have been verified with Ruby 3.4.7, Rice 4.7.1, and
ZXing-CPP 2.2.1 on macOS. Other ZXing-CPP versions have not been verified.

## Credits

- [zxing-cpp](https://github.com/zxing-cpp/zxing-cpp) - C++ barcode library
- [Rice](https://github.com/jasonroelofs/rice) - Ruby Interface for C++ Extensions
- [stb_image](https://github.com/nothings/stb) - Image loading library
