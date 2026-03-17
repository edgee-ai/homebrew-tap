class Edgee < Formula
  desc "Edgee's CLI that runs in your terminal"
  homepage "https://github.com/edgee-ai/edgee"
  version "0.1.2"
  license "Apache-2.0"
  head "https://github.com/edgee-ai/edgee.git", branch: "main"

  # SHA256 checksums by platform
  SHA256_BY_PLATFORM = {
    "aarch64-apple-darwin" => "2399b1a9b70d5f5ab8c98e86bcad80dc57db6fae6b18e9621fb233665dd9088c",
    "x86_64-apple-darwin" => "a9469ef1958fc3d558c48d6df6cde87d857bff41e36f89ed0d52c277b0d7189a",
    "aarch64-unknown-linux-gnu" => "ac4dc97993f2737cb5141b88b41f42a241ffa521290223b33a6aa5908fae2e4c",
    "x86_64-unknown-linux-gnu" => "651bf5e01c85be4b06ad4cf02c5c11559f53cef6b086c1c9a6cd70c1a7c0ad85"
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
