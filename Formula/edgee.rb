class Edgee < Formula
  desc "Edgee's CLI that runs in your terminal"
  homepage "https://github.com/edgee-ai/edgee"
  version "0.15.1"
  license "Apache-2.0"
  head "https://github.com/edgee-ai/edgee.git", branch: "main"

  # SHA256 checksums by platform
  SHA256_BY_PLATFORM = {
    "aarch64-apple-darwin" => "b74e5822cd2d579f916ff161edc8291437bf186f5f8db8b8d2a1f1e7af9e0ded",
    "x86_64-apple-darwin" => "6d832361d318f813096d6a20be3278a626df88016945d3cf3290983ae6ba557b",
    "aarch64-unknown-linux-gnu" => "05400cc48d393e0933d30595bf147ad77c7780fcf995928db80c5d182f0a20c1",
    "x86_64-unknown-linux-gnu" => "4e1818a9965ab8def2769a31bfea46293f2795b61e41745032048c84dd732034"
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
