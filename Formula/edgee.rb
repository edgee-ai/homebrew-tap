class Edgee < Formula
  desc "Edgee's CLI that runs in your terminal"
  homepage "https://github.com/edgee-ai/edgee"
  version "0.11.1"
  license "Apache-2.0"
  head "https://github.com/edgee-ai/edgee.git", branch: "main"

  # SHA256 checksums by platform
  SHA256_BY_PLATFORM = {
    "aarch64-apple-darwin" => "256dd3142db34127259d96120d48d00bd6093fdf430d19681adfe77c1a9b9855",
    "x86_64-apple-darwin" => "f81e8e6ac9cf6018eb7fd0acdf97b1c76723020f94d5122c297da53e1aecdea1",
    "aarch64-unknown-linux-gnu" => "7c049e597d6edb68faf57b23196c8d60cfc2dde11b12924d4bad00b3492d99d1",
    "x86_64-unknown-linux-gnu" => "51ae778f31a6804e9e6d76b8d84e4ab6db9d98a6e7f330c1d4d9d5efe8736e83"
  }.freeze

  on_macos do
    arch = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    platform = "#{arch}-apple-darwin"
    url "https://github.com/edgee-ai/edgee/releases/download/v#{version}/edgee.#{platform}"
    sha256 SHA256_BY_PLATFORM[platform]
  end

  on_linux do
    arch = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    platform = "#{arch}-unknown-linux-gnu"
    url "https://github.com/edgee-ai/edgee/releases/download/v#{version}/edgee.#{platform}"
    sha256 SHA256_BY_PLATFORM[platform]
  end

  def install
    # Find the downloaded binary file
    binary = Dir["#{buildpath}/edgee.*"].first
    raise "Binary not found" unless binary
    
    bin.install binary => "edgee"
    chmod 0555, bin/"edgee"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/edgee --version")
  end
end
