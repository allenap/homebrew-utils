class RustPetname < Formula
  desc "Generate human readable random names"
  homepage "https://crates.io/crates/petname"
  url "https://github.com/allenap/rust-petname/archive/refs/tags/v2.0.2.tar.gz"
  sha256 "135c456fc3df75939fe87679895af4f585789fba926ce998087fdcd38e0a1775"
  license "Apache-2.0"

  head "https://github.com/allenap/rust-petname.git", branch: "master"

  bottle do
    root_url "https://ghcr.io/v2/allenap/utils"
    rebuild 1
    sha256 cellar: :any_skip_relocation, ventura:      "158e882edc8172b4a3839e8b7ec9638a194b84615e9088aa03129d5ea6a3a0cc"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "df5c135ee5b460f5e7a02d8ac7078c997308d0be5bf55619141a2660e1d8a1d9"
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
