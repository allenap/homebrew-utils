class RustPetname < Formula
  desc "Generate human readable random names. Rust port of Dustin Kirkland's petname library."
  homepage "https://crates.io/crates/petname"
  url "https://github.com/allenap/rust-petname/archive/refs/tags/v2.0.2.tar.gz"
  sha256 "135c456fc3df75939fe87679895af4f585789fba926ce998087fdcd38e0a1775"
  license "Apache-2.0"

  depends_on "rust" => :build

  head "https://github.com/allenap/rust-petname.git", branch: "master"

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
