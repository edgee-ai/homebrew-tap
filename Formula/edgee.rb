class Edgee < Formula
  desc "Edgee's CLI that runs in your terminal"
  homepage "https://github.com/edgee-ai/edgee"
  version "0.13.1"
  license "Apache-2.0"
  head "https://github.com/edgee-ai/edgee.git", branch: "main"

  # SHA256 checksums by platform
  SHA256_BY_PLATFORM = {
    "aarch64-apple-darwin" => "e260b2a094b0fd4c18c75729c40b2966a248cfbc0944d1cfe274ca1b6bf2f662",
    "x86_64-apple-darwin" => "93db02ae7f29098ecf897bd577a4fe37c54d492d4b8a1fc7e77f07efc9055928",
    "aarch64-unknown-linux-gnu" => "7fbeddd3fed2789b48ce1d0878d28afa2700be29c1bcb790a69e5c24c7054ce6",
    "x86_64-unknown-linux-gnu" => "2248530b7589b7c7193306e72b36276ba6abc339e6c6a44b8e91c1fcd0059f5d"
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
