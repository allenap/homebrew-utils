class RustPetname < Formula
  desc "Generate human readable random names"
  homepage "https://github.com/allenap/rust-petname"
  url "https://github.com/allenap/rust-petname/archive/refs/tags/v3.0.1.tar.gz"
  sha256 "57dbb72d3e70ef275eea1a477a9f2170835d0f4f22afb6160ae4ec5cf42ad759"
  license "Apache-2.0"

  head "https://github.com/allenap/rust-petname.git", branch: "master"

  livecheck do
    url :stable
    regex(/^v(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/allenap/utils"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "ef30489fef6adabf48c4fc2eb56fb259c8419078f07e2ad977e246cbbfca93ca"
    sha256 cellar: :any,                 x86_64_linux: "637f7d79647ae5d918e9510bce9d0891506c2d7da5272973ee934c277bf8e20c"
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
