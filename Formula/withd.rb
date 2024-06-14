class Withd < Formula
  desc "Run a command in a specific (maybe temporary) directory"
  homepage "https://github.com/allenap/withd"
  url "https://github.com/allenap/withd/archive/refs/tags/v0.3.1.tar.gz"
  sha256 "951f563f9bd6d999f011f4cd08b8cea11183d904fef472a3b39eb6038c6862a9"
  license "GPL-3.0-or-later"

  head "https://github.com/allenap/withd.git", branch: "master"
  depends_on "rust" => :build

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
