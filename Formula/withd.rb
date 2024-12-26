class Withd < Formula
  desc "Run a command in a specific (maybe temporary) directory"
  homepage "https://github.com/allenap/withd"
  url "https://github.com/allenap/withd/archive/refs/tags/v0.3.2.tar.gz"
  sha256 "1ffd3e813c2f3365ac66d4bae1f5905bbd2359ace847d679d793444c02314fa0"
  license "GPL-3.0-or-later"

  head "https://github.com/allenap/withd.git", branch: "master"

  bottle do
    root_url "https://ghcr.io/v2/allenap/utils"
    rebuild 1
    sha256 cellar: :any_skip_relocation, ventura:      "781ef3f4bb4ebe38635889ff9b72ebbd542295123154bed12669b9bfc780943e"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "329a64d71ddf28b3059678c0a6c565f45292dc573d05e63f9117af0d7bcbbb9e"
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
