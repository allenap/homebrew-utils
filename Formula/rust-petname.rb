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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "bdb60b3d37b6497e4a63fa2564129b26103c4ccd1f39b6a73a302097533f5b31"
    sha256 cellar: :any,                 x86_64_linux: "bed711d79d642963d03af9655ece33ba8379e95e6cae5474ecd17d1636b0bac4"
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
