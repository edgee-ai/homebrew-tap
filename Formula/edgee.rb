class Edgee < Formula
  desc "Edgee's CLI that runs in your terminal"
  homepage "https://github.com/edgee-ai/edgee"
  version "0.1.9"
  license "Apache-2.0"
  head "https://github.com/edgee-ai/edgee.git", branch: "main"

  # SHA256 checksums by platform
  SHA256_BY_PLATFORM = {
    "aarch64-apple-darwin" => "dae877551cb184de1d0a7bb5237a471edd471d185e2e24f4e5e6bcb614c23d17",
    "x86_64-apple-darwin" => "9ef804b2b09ed91fc0e8fd5510100dca1bf60b1c8fd6a32e4d6344e7066461dc",
    "aarch64-unknown-linux-gnu" => "3500f8a54ca98cb587b62280f70ae116bbd8c4d592b60f6d8f549e68309abc8e",
    "x86_64-unknown-linux-gnu" => "4c93c05f1cb805a2066e1dce4200dcc1b3539faf82421821a53bd1d77c6c62f5"
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
