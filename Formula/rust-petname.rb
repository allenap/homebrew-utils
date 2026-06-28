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

  bottle do
    root_url "https://ghcr.io/v2/allenap/utils"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "e9f4ee02b92efe95d22dc11d49c7f6306f93024c439b2345c453f7d41613742d"
    sha256 cellar: :any,                 x86_64_linux: "e169130bb9eb1c2bb6f14395f06be1ec8f07dda17aec606e33329b6e0910f233"
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
