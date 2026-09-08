class Edgee < Formula
  desc "Edgee's CLI that runs in your terminal"
  homepage "https://github.com/edgee-ai/edgee"
  version "0.8.0"
  license "Apache-2.0"
  head "https://github.com/edgee-ai/edgee.git", branch: "main"

  # SHA256 checksums by platform
  SHA256_BY_PLATFORM = {
    "aarch64-apple-darwin" => "8fd0f1a05fb1b60ecbd27d193e7a7d8b7fd5cdc7071399df11c0b732f5c0b532",
    "x86_64-apple-darwin" => "e912a0b16b4cbb45e8041cac5fd3abbeb9722dfb1751d76b384519583574406f",
    "aarch64-unknown-linux-gnu" => "970831cdbe2dc57e1653814b4ab945b023e9bdbb6d77bb4daaf483aebfff6ed4",
    "x86_64-unknown-linux-gnu" => "8c2c6b7e4672db86e0cd7c21eff38805b16d5dcd23e25109da42adf1adb8d50a"
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
