class Edgee < Formula
  desc "Edgee's CLI that runs in your terminal"
  homepage "https://github.com/edgee-ai/edgee"
  version "0.18.2"
  license "Apache-2.0"
  head "https://github.com/edgee-ai/edgee.git", branch: "main"

  # SHA256 checksums by platform
  SHA256_BY_PLATFORM = {
    "aarch64-apple-darwin" => "955a161471bc5d3817561b0252cc7faf1bb6ea4f377765f1eb3f4f6888e5967e",
    "x86_64-apple-darwin" => "534d0f3dd85226470640f370e47586c3f1cb37e0834f8ee3f46e9331bd723cd7",
    "aarch64-unknown-linux-gnu" => "2b6ca368dff936e855f608ae6382b253e76936c963c1ecf4b46c944188a3f17d",
    "x86_64-unknown-linux-gnu" => "e1bfd5a29c77eb63ef7ee65a3e7fdd690ff7b0ebf83b5e512190d24d8c61b31a"
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
