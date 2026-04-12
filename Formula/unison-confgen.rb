class UnisonConfgen < Formula
  desc "Generate Unison File Synchronizer configurations"
  homepage "https://github.com/allenap/unison-confgen"
  url "https://github.com/allenap/unison-confgen/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "040c22c5bf023d8080ac49d3678278dbd1d2e231cea9ee206e222acbaba022b8"
  license "GPL-3.0-or-later"

  head "https://github.com/allenap/unison-confgen.git", branch: "master"

  livecheck do
    url :stable
    regex(/^v(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/allenap/utils"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "cea8118c8a9a60a0b307c7c2cefe9eab286e94227b635e2b04cb8db9a3819e79"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "5c4a9a3106a451817c5a19aa87fbdfbab31ee9738170cfbf70943adf4e5b94d4"
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
