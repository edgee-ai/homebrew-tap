class Edgee < Formula
  desc "Edgee's CLI that runs in your terminal"
  homepage "https://github.com/edgee-ai/edgee"
  version "0.15.4"
  license "Apache-2.0"
  head "https://github.com/edgee-ai/edgee.git", branch: "main"

  # SHA256 checksums by platform
  SHA256_BY_PLATFORM = {
    "aarch64-apple-darwin" => "cd672834acec8982dd1b149272878e3e1054a2f59bb291125000f264e5815b1a",
    "x86_64-apple-darwin" => "c47c8ad39c41e398e7c3b8a90a4ce331bdcf913a88c2641783c9b8dbe6d90ef4",
    "aarch64-unknown-linux-gnu" => "048f23c8a4c2c80635c41a3b5bd58d32d75dba4ed36a99cb735e0f9d925b2d6c",
    "x86_64-unknown-linux-gnu" => "49f36bf79acdeb30b2e41ab2c233ba6e114472a5361659c9a9e2fe6549e887bc"
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
