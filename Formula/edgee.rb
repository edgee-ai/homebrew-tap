class Edgee < Formula
  desc "Edgee's CLI that runs in your terminal"
  homepage "https://github.com/edgee-ai/edgee"
  version "0.15.0"
  license "Apache-2.0"
  head "https://github.com/edgee-ai/edgee.git", branch: "main"

  # SHA256 checksums by platform
  SHA256_BY_PLATFORM = {
    "aarch64-apple-darwin" => "9e03b2038ba5ed2379f68e99413c97d0b47a3c53e067925dff4e8a112a57e5a0",
    "x86_64-apple-darwin" => "f09245dd22ff0f8abbdd04188532ca9464ee25690a2a828bc64b8a2cae909e2d",
    "aarch64-unknown-linux-gnu" => "aa65c6ff93763720c0ea4de9ca43918ee1543fbbfc4f27fdeddc25da6f314d97",
    "x86_64-unknown-linux-gnu" => "2622bc86693b6b8c5f1e74a246304fcadc30a8f67962d8816329b6797627ec27"
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
