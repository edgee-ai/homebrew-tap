class Edgee < Formula
  desc "Edgee's CLI that runs in your terminal"
  homepage "https://github.com/edgee-ai/edgee"
  version "0.16.5"
  license "Apache-2.0"
  head "https://github.com/edgee-ai/edgee.git", branch: "main"

  # SHA256 checksums by platform
  SHA256_BY_PLATFORM = {
    "aarch64-apple-darwin" => "06fcfa2c895a3153266e6b1ef0b0eea5cc3c73486b4c6e6d31c5614c1e88b5f0",
    "x86_64-apple-darwin" => "71bde688b9d50bd4cfc57d022e52e2ff641358a8204c5ad981d86230f98fe6bb",
    "aarch64-unknown-linux-gnu" => "cb9513aae9162dc8e2ad4fde7909c48479899121fae893a04cc5def75d6bc365",
    "x86_64-unknown-linux-gnu" => "48803ef823f5a24f001c38a303069197ad31fcad051b8c3603f76ec644126d29"
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
