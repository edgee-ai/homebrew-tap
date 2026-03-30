class Edgee < Formula
  desc "Edgee's CLI that runs in your terminal"
  homepage "https://github.com/edgee-ai/edgee"
  version "0.1.11"
  license "Apache-2.0"
  head "https://github.com/edgee-ai/edgee.git", branch: "main"

  # SHA256 checksums by platform
  SHA256_BY_PLATFORM = {
    "aarch64-apple-darwin" => "fc4ce0f8287268498be6a8d4ebe4f37428ea3c1d212f8a3ed790c3f6a1b9cbaf",
    "x86_64-apple-darwin" => "badc2d2f7e542ba054943275c95f20ce9d27f5f92f405498fc4aa24715deff73",
    "aarch64-unknown-linux-gnu" => "89164b62449576fd878815a663fba2b39183b8c27f11bbebc283123c292ad2c5",
    "x86_64-unknown-linux-gnu" => "e32cfe5f2ca1a36bec2809cc16b5fb840c168f9f3059f90a0a8b2557bc75509b"
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
