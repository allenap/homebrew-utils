class Withd < Formula
  desc "Run a command in a specific directory or in a temporary directory."
  homepage "https://github.com/allenap/withd"
  url "https://github.com/allenap/withd/archive/refs/tags/v0.2.3.tar.gz"
  sha256 "247320969cdcb1f139f55717b2afd347e0811b63640b8bbd99f6b3835cc845c7"
  license "GPL-3.0-or-later"

  depends_on "rust" => :build

  head "https://github.com/allenap/withd.git", branch: "master"

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    system "#{bin}/withd", "--help"
    system "#{bin}/withd", "-c", "alice/one", "pwd"
    system "#{bin}/withd", "--create", "bob/one", "pwd"
    system "#{bin}/withd", "-tc", "carol/one.XXXXXX.two", "pwd"
    system "#{bin}/withd", "--temporary", "--create", "dave/one.XXXXXX.two", "pwd"
    system "#{bin}/withd", "-tc", "eve.XXXXXX", "pwd"
    system "#{bin}/withd", "-tc", "", "pwd"
  end
end
