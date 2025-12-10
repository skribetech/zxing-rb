/*
* Copyright 2025 ZXing-CPP Contributors
*/
// SPDX-License-Identifier: Apache-2.0

// Requires C++20
#define STB_IMAGE_IMPLEMENTATION
#include "stb_image.h"

#include <ZXing/ReadBarcode.h>
#include <ZXing/ImageView.h>
#include <ZXing/ReaderOptions.h>
#include <ZXing/BarcodeFormat.h>

#include <rice/rice.hpp>
#include <rice/stl.hpp>

#include <memory>
#include <stdexcept>
#include <string>

using namespace ZXing;
using namespace Rice;
using Rice::detail::to_ruby;

/**
 * Read first DataMatrix code from image file
 *
 * @param path Path to image file (JPEG, PNG, BMP, etc.)
 * @return Decoded text as String, or nil if no DataMatrix found
 * @raise RuntimeError if file cannot be read or image format is invalid
 */
Object read_datamatrix(std::string path) {
    // Load image using stb_image (RGB format, 3 channels)
    int width, height, channels;
    std::unique_ptr<stbi_uc, void(*)(void*)> buffer(
        stbi_load(path.c_str(), &width, &height, &channels, 3),
        stbi_image_free
    );

    if (!buffer) {
        std::string error = "Failed to load image: ";
        error += stbi_failure_reason();
        throw std::runtime_error(error);
    }

    // Create ImageView (non-owning wrapper around pixel data)
    ImageView image{buffer.get(), width, height, ImageFormat::RGB};

    // Configure reader options
    ReaderOptions options;
    options.setFormats(BarcodeFormat::DataMatrix);  // Only DataMatrix
    options.setTryRotate(true);                     // Try 90/180/270 degrees
    options.setTryDownscale(true);                  // Try downscaled versions
    options.setTextMode(TextMode::HRI);             // Human Readable Interpretation

    // Read first barcode
    Result result = ReadBarcode(image, options);

    // Return text if valid, nil otherwise
    if (result.isValid()) {
        return to_ruby(result.text());
    } else {
        return Object(Qnil);
    }
}

/**
 * Ruby extension initialization
 * Defines module Zxing with method read_datamatrix
 */
extern "C"
void Init_zxing() {
    Module rb_mZxing = define_module("Zxing");

    rb_mZxing.define_module_function(
        "read_datamatrix",
        &read_datamatrix,
        Arg("path")
    );
}
