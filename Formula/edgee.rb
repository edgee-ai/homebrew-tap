class Edgee < Formula
  desc "Edgee's CLI that runs in your terminal"
  homepage "https://github.com/edgee-ai/edgee"
  version "0.3.5"
  license "Apache-2.0"
  head "https://github.com/edgee-ai/edgee.git", branch: "main"

  # SHA256 checksums by platform
  SHA256_BY_PLATFORM = {
    "aarch64-apple-darwin" => "e29dd3a524a50eed3992f6f909e33416f0b55bff80e73a2719bf2d73ba3382a6",
    "x86_64-apple-darwin" => "73e96f4f43e7bef85bb403307a8c5b118ede5bff13cb9af0c7669da886d89da6",
    "aarch64-unknown-linux-gnu" => "3f78d9981d6b0aaa06b9b0723a80fddcff01e9279e0f5cbb5efe0d49a2f1d566",
    "x86_64-unknown-linux-gnu" => "ff4b0b158f37f6df1dbc0aa5c894d206411d6f0a23ff075f4089e5a1dbcdeeec"
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
