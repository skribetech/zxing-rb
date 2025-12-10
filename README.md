# Zxing-C++ Ruby Wrapper

Ruby wrapper for [zxing-cpp](https://github.com/zxing-cpp/zxing-cpp) to read DataMatrix barcodes from images.

## Features

- Simple API: `Zxing.read_datamatrix(path)` → String or nil
- Reads DataMatrix codes from JPEG, PNG, BMP, and other image formats

## Requirements

### System Requirements

- **C++ Compiler**: C++20 support required
- **ZXing-CPP**: System-installed library (libzxing-dev)
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

## Credits

- [zxing-cpp](https://github.com/zxing-cpp/zxing-cpp) - C++ barcode library
- [Rice](https://github.com/jasonroelofs/rice) - Ruby Interface for C++ Extensions
- [stb_image](https://github.com/nothings/stb) - Image loading library
