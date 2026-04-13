class Withd < Formula
  desc "Run a command in a specific (maybe temporary) directory"
  homepage "https://github.com/allenap/withd"
  url "https://github.com/allenap/withd/archive/refs/tags/v0.3.3.tar.gz"
  sha256 "b3eeffe7079900461f8a659b698f326fdb14b8b60e0b08bc302c1486a1d74e21"
  license "GPL-3.0-or-later"

  head "https://github.com/allenap/withd.git", branch: "master"

  livecheck do
    url :stable
    regex(/^v(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/allenap/utils"
    sha256 cellar: :any_skip_relocation, ventura:      "e7f128c85d0aa3c3f32dcf899cb2716e918d4dbfa147d74844921970f9865b73"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "12eff5451fa1ae931a446c3db3406ac2705336787dd52de05fe9a166c6932a84"
  end
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
