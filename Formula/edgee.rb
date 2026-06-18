class Edgee < Formula
  desc "Edgee's CLI that runs in your terminal"
  homepage "https://github.com/edgee-ai/edgee"
  version "0.2.9"
  license "Apache-2.0"
  head "https://github.com/edgee-ai/edgee.git", branch: "main"

  # SHA256 checksums by platform
  SHA256_BY_PLATFORM = {
    "aarch64-apple-darwin" => "b7f7eebd4ef3cadd64bfe11d8c2f686e880f8198d1fc590334fa71c3ae06a0f5",
    "x86_64-apple-darwin" => "8dc64a9c77203950f50cd1210be537dadc8daf95302003b0be51d1204e5d9188",
    "aarch64-unknown-linux-gnu" => "de67eb9e63b045493ab90d1e26c1a4ec73d7f71a8fb06dcfc8cfb836822d97b9",
    "x86_64-unknown-linux-gnu" => "57debbd2761528a9a4bcc0791b3ea64b94a4483e88cc80e6d92d1d430c82fc38"
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
