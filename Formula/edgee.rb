class Edgee < Formula
  desc "Edgee's CLI that runs in your terminal"
  homepage "https://github.com/edgee-ai/edgee"
  version "0.5.2"
  license "Apache-2.0"
  head "https://github.com/edgee-ai/edgee.git", branch: "main"

  # SHA256 checksums by platform
  SHA256_BY_PLATFORM = {
    "aarch64-apple-darwin" => "f66a5c4b47218f1b0ec9de9648ff510deeeab8976adf3dc5762e5ad6e8ca5904",
    "x86_64-apple-darwin" => "7659b7d0f1d34dc3bcd6e7336d4a22fc358114cfd7388bee5b9ec81ce3b529c1",
    "aarch64-unknown-linux-gnu" => "62e71995b04b5a486d2bc5b3c901efc4b5b850c76b002093d91196f97710cc5e",
    "x86_64-unknown-linux-gnu" => "06866530d82cccdabcec34b780be991b86d7a5995148fb80d656cbae82969f44"
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
