require 'minitest/autorun'
require 'tempfile'
require_relative '../lib/zxing'

class TestQRCode < Minitest::Test
  FIXTURES = File.join(__dir__, 'fixtures')
  URL_TEXT = 'https://example.com/qr?value=42'

  def test_reads_url
    assert_equal URL_TEXT, Zxing.read_qrcode(File.join(FIXTURES, 'qr_url.png'))
  end

  def test_reads_unicode
    result = Zxing.read_qrcode(File.join(FIXTURES, 'qr_unicode.png'))
    assert_equal 'Bonjour, été — 日本語 👋', result
    assert_equal Encoding::UTF_8, result.encoding
    assert result.valid_encoding?
  end

  def test_reads_rotated_codes
    [90, 180, 270].each do |angle|
      assert_equal URL_TEXT, Zxing.read_qrcode(File.join(FIXTURES, "qr_url_rotated_#{angle}.png"))
    end
  end

  def test_blank_image_returns_nil
    [:read_qrcode, :read_datamatrix].each do |reader|
      assert_nil Zxing.public_send(reader, File.join(FIXTURES, 'blank.png'))
    end
  end

  def test_qrcode_reader_ignores_datamatrix
    assert_nil Zxing.read_qrcode(File.join(__dir__, 'dc04_sample_small.jpeg'))
  end

  def test_datamatrix_reader_ignores_qrcode
    assert_nil Zxing.read_datamatrix(File.join(FIXTURES, 'qr_url.png'))
  end

  def test_missing_file_raises
    error = assert_raises(RuntimeError) { Zxing.read_qrcode(File.join(FIXTURES, 'missing.png')) }
    assert_match(/Failed to load image/, error.message)
  end

  def test_invalid_image_raises
    Tempfile.create(['invalid', '.png']) do |file|
      file.write('This is not an image')
      file.flush
      error = assert_raises(RuntimeError) { Zxing.read_qrcode(file.path) }
      assert_match(/Failed to load image/, error.message)
    end
  end
end
