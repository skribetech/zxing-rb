Gem::Specification.new do |spec|
  spec.name          = "zxing"
  spec.version       = "0.1.0"
  spec.authors       = ["Sagane"]

  spec.summary       = "Ruby wrapper for zxing-cpp DataMatrix barcode reader"
  spec.description   = "Read DataMatrix barcodes from images using the zxing-cpp library"
  spec.homepage      = "https://github.com/zxing-cpp/zxing-cpp"
  spec.required_ruby_version = ">= 3.4.0"

  # Files to include in gem
  spec.files = Dir[
    "lib/**/*.rb",
    "ext/**/*.{cpp,h,rb}",
    "README.md"
  ]

  spec.require_paths = ["lib"]
  spec.extensions = ["ext/zxing/extconf.rb"]

  # Dependencies
  spec.add_dependency "rice", "~> 4.0"

  # Development dependencies
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rake-compiler", "~> 1.2"
  spec.add_development_dependency "minitest", "~> 5.0"
end
