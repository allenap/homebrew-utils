class Withd < Formula
  desc "Run a command in a specific directory or in a temporary directory."
  homepage "https://github.com/allenap/withd"
  url "https://github.com/allenap/withd/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "4cef2eefea059c190f565f6d01215856a6abc2507e5941cc152b74cf29787d30"
  license "GPL-3.0-or-later"

  depends_on "rust" => :build

  head "https://github.com/allenap/withd.git", branch: "master"

  def install
    system "cargo", "install", *std_cargo_args
    bash_completion.install "completions/withd.bash" => "withd"
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
