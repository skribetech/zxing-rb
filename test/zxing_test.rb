require 'minitest/autorun'
require_relative '../lib/zxing'

class TestZxing < Minitest::Test
  # Path to test image (in test/ folder)
  TEST_IMAGE = File.join(__dir__, 'dc04_sample_small.jpeg')
  EXPECTED_TEXT_FILE = File.join(__dir__, 'dc04_sample_text.md')

  def test_module_exists
    assert defined?(Zxing), "Zxing module should be defined"
  end

  def test_version
    assert_equal "0.2.0", Zxing::VERSION
  end

  def test_read_datamatrix_method_exists
    assert_respond_to Zxing, :read_datamatrix
  end

  def test_read_datamatrix_with_valid_image
    skip "Test image not found" unless File.exist?(TEST_IMAGE)

    result = Zxing.read_datamatrix(TEST_IMAGE)

    refute_nil result, "Should find DataMatrix code in sample image"
    assert_instance_of String, result, "Result should be a String"
    assert result.length > 0, "Result should not be empty"

    # Verify it starts with expected prefix (DC04FR)
    assert result.start_with?("DC04FR"), "Result should start with DC04FR"
  end

  def test_read_datamatrix_matches_expected_text
    skip "Test files not found" unless File.exist?(TEST_IMAGE) && File.exist?(EXPECTED_TEXT_FILE)

    result = Zxing.read_datamatrix(TEST_IMAGE)
    expected = File.read(EXPECTED_TEXT_FILE).strip

    assert_equal expected, result, "Result should match expected text file"
  end

  def test_read_datamatrix_with_nonexistent_file
    error = assert_raises(RuntimeError) do
      Zxing.read_datamatrix('/nonexistent/file.jpg')
    end

    assert_match(/Failed to load image/, error.message)
  end

  def test_read_datamatrix_returns_nil_for_invalid_file
    # Test with a text file (not an image)
    require 'tempfile'

    Tempfile.create(['test', '.txt']) do |f|
      f.write("This is not an image")
      f.flush

      error = assert_raises(RuntimeError) do
        Zxing.read_datamatrix(f.path)
      end

      assert_match(/Failed to load image/, error.message)
    end
  end
end
