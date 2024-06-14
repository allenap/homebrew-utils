class UnisonConfgen < Formula
  desc "Generate Unison File Synchronizer configurations"
  homepage "https://github.com/allenap/unison-confgen"
  url "https://github.com/allenap/unison-confgen/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "665867d36dba4c0196bfb939bf3fe5513ad6815dbd7e774be13e98e70851f979"
  license "GPL-3.0-or-later"

  head "https://github.com/allenap/unison-confgen.git", branch: "master"

  bottle do
    root_url "https://ghcr.io/v2/allenap/utils"
    rebuild 1
    sha256 cellar: :any_skip_relocation, ventura:      "4fbd8344fe47816ad9eb741ad7531405d92fc44dde2b1bbbd4e7e08d60176685"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "4bb89a77a3e40e687e60dad22bd7ba6c8d6adce88c0f83258b9954260fd576db"
  end
  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    require "open3"
    hostname = `hostname -s`.strip
    Open3.popen3("#{bin}/unison-confgen") do |stdin, _stdout, _stderr|
      stdin.puts "hosts:\n  #{hostname}:"
      stdin.close
    end
  end
end
