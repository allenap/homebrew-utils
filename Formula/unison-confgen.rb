class UnisonConfgen < Formula
  desc "Tool for generating my Unison File Synchronizer configurations."
  homepage "https://github.com/allenap/unison-confgen"
  url "https://github.com/allenap/unison-confgen/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "665867d36dba4c0196bfb939bf3fe5513ad6815dbd7e774be13e98e70851f979"
  license "GPL-3.0-or-later"

  depends_on "rust" => :build

  head "https://github.com/allenap/unison-confgen.git", branch: "master"

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    require 'open3'
    hostname = `hostname -s`.strip
    Open3.popen3("#{bin}/unison-confgen") do |stdin, stdout, stderr|
      stdin.puts "hosts:\n  #{hostname}:"
      stdin.close
    end
  end
end
