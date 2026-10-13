class Edgee < Formula
  desc "Edgee's CLI that runs in your terminal"
  homepage "https://github.com/edgee-ai/edgee"
  version "0.14.3"
  license "Apache-2.0"
  head "https://github.com/edgee-ai/edgee.git", branch: "main"

  # SHA256 checksums by platform
  SHA256_BY_PLATFORM = {
    "aarch64-apple-darwin" => "f83b1d95149d48c49dfcd2b74805165dccf90312d1fdd27f1c3f1f4f7fe3cf1c",
    "x86_64-apple-darwin" => "248eb50b05f3039af5ea380a62764f68d6b053adbcb977f18453eb7768932982",
    "aarch64-unknown-linux-gnu" => "6b6a862685aa87bb0dd943aa24d7bc03907ed5f0d27e3f38862a10d95da7c0af",
    "x86_64-unknown-linux-gnu" => "5bc5762eda8666ba8a9af49ff90de0be0beab98208045ce4ddba265da6a7c921"
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
