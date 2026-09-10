# QR fixtures

These synthetic fixtures were generated with ZXing-CPP 2.2.1 MultiFormatWriter,
using QRCode, UTF-8 encoding (ECI), margin 4, and a 200 × 200 image size.
The matrices were saved as lossless grayscale PNGs. No generator dependency is
needed to run the tests.

- `qr_url.png`: `https://example.com/qr?value=42`
- `qr_url_rotated_90.png`, `qr_url_rotated_180.png`, and
  `qr_url_rotated_270.png`: the URL matrix after one, two, or three calls to
  BitMatrix::rotate90().
- `qr_unicode.png`: `Bonjour, été — 日本語 👋`
- `blank.png`: a 200 × 200 all-white image.
