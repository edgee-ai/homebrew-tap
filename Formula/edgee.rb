class Edgee < Formula
  desc "Edgee's CLI that runs in your terminal"
  homepage "https://github.com/edgee-ai/edgee"
  version "0.2.1"
  license "Apache-2.0"
  head "https://github.com/edgee-ai/edgee.git", branch: "main"

  # SHA256 checksums by platform
  SHA256_BY_PLATFORM = {
    "aarch64-apple-darwin" => "9f3f79a33c0d826208a3eb00e4463fb056a0064ab3302ab3461a14f44c1741dd",
    "x86_64-apple-darwin" => "98cab8a2613cbb289f1a01dd99d6559f8f59f2456c57558a75b1b9ea304ffebe",
    "aarch64-unknown-linux-gnu" => "70fb853332fa5514d7da013d693a8ab2dd2d1636cf3fe9ebdecb31e7aad4fc23",
    "x86_64-unknown-linux-gnu" => "1771a9303b6ee051ac4732b4d59798f73462eee852acf1e48af0e4bc27df1c2e"
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
