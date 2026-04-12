class RustPetname < Formula
  desc "Generate human readable random names"
  homepage "https://github.com/allenap/rust-petname"
  url "https://github.com/allenap/rust-petname/archive/refs/tags/v3.0.0.tar.gz"
  sha256 "0ca900689f19eae09af866d3736144e70eb2b2e0c722e2d139f92f753a24e767"
  license "Apache-2.0"

  head "https://github.com/allenap/rust-petname.git", branch: "master"

  bottle do
    root_url "https://ghcr.io/v2/allenap/utils"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "7fed414ba5309177b61eea996b1ffbf5b484aa100f724ba2d24a24c946809363"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "98baa12f59094cba836ecb8cf8548ea2b3f1a269adb8d339d550604ab6f5c4be"
  end
  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    system "#{bin}/petname",
      "--words", "5",
      "--separator", "/",
      "--lists", "large",
      "--count", "10"
  end
end
