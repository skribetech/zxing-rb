require 'rake/testtask'
require 'rake/extensiontask'

# Build extension
Rake::ExtensionTask.new('zxing') do |ext|
  ext.lib_dir = 'lib/zxing'
  ext.ext_dir = 'ext/zxing'
end

# Test task
Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.test_files = FileList['test/**/*_test.rb']
end

# Default task: compile then test
task default: [:compile, :test]
