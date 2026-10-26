class Edgee < Formula
  desc "Edgee's CLI that runs in your terminal"
  homepage "https://github.com/edgee-ai/edgee"
  version "0.15.2"
  license "Apache-2.0"
  head "https://github.com/edgee-ai/edgee.git", branch: "main"

  # SHA256 checksums by platform
  SHA256_BY_PLATFORM = {
    "aarch64-apple-darwin" => "d3f0b9d6d485977be099be20b79cce5c356401fd93eee39010b5badb77a724b2",
    "x86_64-apple-darwin" => "5cceda0b0860c3b82ac07fe68a4ce63c4861ec507c5b5c438e941f777be9b7a9",
    "aarch64-unknown-linux-gnu" => "469c8dec8248cdce6b2f8ce46425b15148eea2278578eb39eb9c7e063c8e4911",
    "x86_64-unknown-linux-gnu" => "9a9f506dced5ba1aedd3e94498b6dcd0867e9526cbd58709158022527188deb8"
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
