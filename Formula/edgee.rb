class Edgee < Formula
  desc "Edgee's CLI that runs in your terminal"
  homepage "https://github.com/edgee-ai/edgee"
  version "0.2.8"
  license "Apache-2.0"
  head "https://github.com/edgee-ai/edgee.git", branch: "main"

  # SHA256 checksums by platform
  SHA256_BY_PLATFORM = {
    "aarch64-apple-darwin" => "c4a3279725f825ae9ed488d8d3970d2f1ee1bfc2076725d3f3ec2da2e9198bbd",
    "x86_64-apple-darwin" => "16315cfd2db795784950bcc552394c66616dac42507523cef84490bb63f6f8f2",
    "aarch64-unknown-linux-gnu" => "370a3d6dd16fa2055dba5eada7022abc790aea8feba8c15320d29073a33892e3",
    "x86_64-unknown-linux-gnu" => "036022cfe23a04926b5a907d2e7b73327864c058787e370059ada99a3452f489"
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
