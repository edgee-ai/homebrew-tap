class Edgee < Formula
  desc "Edgee's CLI that runs in your terminal"
  homepage "https://github.com/edgee-ai/edgee"
  version "0.5.5"
  license "Apache-2.0"
  head "https://github.com/edgee-ai/edgee.git", branch: "main"

  # SHA256 checksums by platform
  SHA256_BY_PLATFORM = {
    "aarch64-apple-darwin" => "529f229924da34208bce2d6d9ec9cd3de69c86fa088beeac5c82f43cae1fe493",
    "x86_64-apple-darwin" => "073c79c7f06d2bc7c41fe20ee887ac1b187c389ec4dd5d4dbdb8653a5fd8b7cd",
    "aarch64-unknown-linux-gnu" => "92cf1fd8616cdaea8df3ab7a86b91cb6b0bccf28c04d03896ada842d72df7f36",
    "x86_64-unknown-linux-gnu" => "23a48feef39c84c05ecdd503d57110e794091857e0a454aa8c42e93abf02f195"
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
