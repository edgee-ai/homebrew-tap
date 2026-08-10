class Edgee < Formula
  desc "Edgee's CLI that runs in your terminal"
  homepage "https://github.com/edgee-ai/edgee"
  version "0.4.0"
  license "Apache-2.0"
  head "https://github.com/edgee-ai/edgee.git", branch: "main"

  # SHA256 checksums by platform
  SHA256_BY_PLATFORM = {
    "aarch64-apple-darwin" => "f8f8ea2dca078ba3fe68d3e9513b05fc9ec97e01f30fe0e84734a14fc26bd4b5",
    "x86_64-apple-darwin" => "3ce0cc59820782d19b84ee5e0d7b99ceb2b3a43ce71b6cb9c972a7d6e6e7fb85",
    "aarch64-unknown-linux-gnu" => "47068f5a523ebc9dd1deee2b9752d536c96396fb3d306b10656f65eb8e697437",
    "x86_64-unknown-linux-gnu" => "df5b30a68f5764bb9998ca4f19ab27855bbf32a5c6e70d2c3ed3baea64839ca0"
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
