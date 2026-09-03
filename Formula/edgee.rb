class Edgee < Formula
  desc "Edgee's CLI that runs in your terminal"
  homepage "https://github.com/edgee-ai/edgee"
  version "0.7.0"
  license "Apache-2.0"
  head "https://github.com/edgee-ai/edgee.git", branch: "main"

  # SHA256 checksums by platform
  SHA256_BY_PLATFORM = {
    "aarch64-apple-darwin" => "4d55a8953143cb19a27cac54676bb12868d64b018cace0fcabc529bfcc928e67",
    "x86_64-apple-darwin" => "dbebe44a97a9bd6dccef5d38bf24a261ab4495b5d7ef80d07572a0ad90801684",
    "aarch64-unknown-linux-gnu" => "8cf1f62348c6299be3b9a69f4f0849348fd5613ccae9c8640dbc581b11bda068",
    "x86_64-unknown-linux-gnu" => "e1403860af7402147e555d929799c93ea69c079b9d2158cc2f0025191aba7b97"
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

  def caveats
    <<~EOS
      This installs only the `edgee` command-line tool.

      For the macOS menubar app — which bundles a matching `edgee` CLI on your
      PATH — install the cask instead (it conflicts with this formula, so pick one):
        brew install --cask edgee-ai/tap/edgee-menubar
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/edgee --version")
  end
end
