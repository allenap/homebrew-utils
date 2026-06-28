class RustPetname < Formula
  desc "Generate human readable random names"
  homepage "https://github.com/allenap/rust-petname"
  url "https://github.com/allenap/rust-petname/archive/refs/tags/v3.0.1.tar.gz"
  sha256 "57dbb72d3e70ef275eea1a477a9f2170835d0f4f22afb6160ae4ec5cf42ad759"
  license "Apache-2.0"
  revision 1

  head "https://github.com/allenap/rust-petname.git", branch: "master"

  livecheck do
    url :stable
    regex(/^v(\d+(?:\.\d+)+)$/i)
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args, "--all-features"
  end

  test do
    system "#{bin}/petname",
      "--words", "5",
      "--separator", "/",
      "--lists", "large",
      "--count", "10"
    # The --all-features build includes the Turkish generator.
    system "#{bin}/petname", "--language", "turkish", "--words", "2"
  end
end
