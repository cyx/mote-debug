require "digest/md5"
require "fileutils"

# This mote plugin is meant to be used only during
# development, to help with debugging errors.
#
# You debug errors by checking out:
#
#     tmp/cache/mote/*.mote.rb
#
# The files written here are compiled, and you can
# explore how mote actually writes them. When you
# run into an error, the browser reports the line
# number in these files. From there you can check
# the actual offending line in the compiled mote file.
#
class Mote
  # This overrides the standard `Mote::compile` method
  # by writing the compiled form into a file, and passing
  # the filename into instance_eval. That way errors
  # can be properly traced back to the actual offending line.
  def self.compile(context, parts)
    FileUtils.mkdir_p(cache_path) unless File.directory?(cache_path)

    cache(parts) do |path|
      context.instance_eval(parts, path, 1)
    end
  end

  def self.cache(data)
    # First we write the generated the filename using the MD5
    # of the data. This prevents us from re-writing them if
    # ever we've already done so.
    path = cache_path(Digest::MD5.hexdigest(data) + ".mote.rb")

    # Now we can write the file into the specified path, if
    # it doesn't exist yet.
    write(path, data) unless File.exist?(path)

    yield path
  end

  # The default cache path is in your project /tmp folder.
  def self.cache_path(*args)
    File.join(Dir.pwd, "tmp/cache/mote", *args)
  end

  def self.write(path, parts)
    File.open(path, "w") { |f| f.write(parts) }
  end
end
