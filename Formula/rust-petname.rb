class RustPetname < Formula
  desc "Generate human readable random names"
  homepage "https://github.com/allenap/rust-petname"
  url "https://github.com/allenap/rust-petname/archive/refs/tags/v3.2.0.tar.gz"
  sha256 "9bd155923eb72e158b7e9905fc75c966c3d006ad45bdcc6788d3e264d92f547c"
  license "Apache-2.0"

  head "https://github.com/allenap/rust-petname.git", branch: "master"

  livecheck do
    url :stable
    regex(/^v(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/allenap/utils"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "9a721db95a28c231256c1d9b7881eeb34d6b0652b3561c4a26a08382982195aa"
    sha256 cellar: :any,                 x86_64_linux: "a5cce620cbbbdb3f77aaa84bfefa5e0df8ce1b6020b399b09308146bf8e3bafd"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args, "--all-features"
    generate_completions_from_executable(bin/"petname", "completions")
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
