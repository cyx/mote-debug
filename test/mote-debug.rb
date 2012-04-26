require "mote"
require_relative "../lib/mote/debug"

setup do
  "./tmp/cache/mote"
end

test do |dir|
  Mote.parse("{{ ' foo bar '.strip }}").call

  assert File.directory?(dir)

  files = Dir[File.join(dir, "*")]

  assert_equal 1, files.size

  compiled = File.read(files.first)
  assert files.first.include?(Digest::MD5.hexdigest(compiled))
end

FileUtils.rm_rf("./tmp")
