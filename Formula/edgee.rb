class Edgee < Formula
  desc "Edgee's CLI that runs in your terminal"
  homepage "https://github.com/edgee-ai/edgee"
  version "0.13.2"
  license "Apache-2.0"
  head "https://github.com/edgee-ai/edgee.git", branch: "main"

  # SHA256 checksums by platform
  SHA256_BY_PLATFORM = {
    "aarch64-apple-darwin" => "3fb9ce4e88f56885a39cd527fc80b995358165d6c5dbd92225eff844bff87106",
    "x86_64-apple-darwin" => "abbceaf557483e5f79a738f256922b7af31df8b3bc3dc19bf2f8f1f720b1f2f4",
    "aarch64-unknown-linux-gnu" => "07aca6755a5548c87cf73bc0dff52b048512c0edd408e8187eb30aa4b5015c33",
    "x86_64-unknown-linux-gnu" => "2dbb6cead3f4f84ce59d364cd5960e9e8bca8a42edbb4aaf648746c03ead9fbc"
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
