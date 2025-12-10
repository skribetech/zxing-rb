require 'mkmf-rice' # Loads mkmf AND sets up Rice include/lib paths automatically

# 1. Enable C++20 (Required by zxing-cpp)
$CXXFLAGS += " -std=c++20"

# 2. Check for zxing-cpp library using pkg-config
#    mkmf-rice/mkmf helpers handles the heavy lifting
unless pkg_config('zxing')
  abort "ERROR: zxing-cpp library not found.\n  macOS: brew install zxing-cpp\n  Linux: apt-get install libzxing-dev"
end

# 3. Create the Makefile
#    This will create the binary at ext/zxing/zxing.so
create_makefile('zxing/zxing')
