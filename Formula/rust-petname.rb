class RustPetname < Formula
  desc "Generate human readable random names"
  homepage "https://github.com/allenap/rust-petname"
  url "https://github.com/allenap/rust-petname/archive/refs/tags/v3.1.0.tar.gz"
  sha256 "ac72beba2e8e5272ab58609de84f1f50f7474d978fddff78d1724218ea354516"
  license "Apache-2.0"

  head "https://github.com/allenap/rust-petname.git", branch: "master"

  livecheck do
    url :stable
    regex(/^v(\d+(?:\.\d+)+)$/i)
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
