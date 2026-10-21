# References: https://github.com/Homebrew/homebrew-core/blob/d89a759a2b2e3bfd35c1dc39eb4aa549dc14f078/Formula/o/oh-my-posh.rb
# @repo https://github.com/JanDeDobbeleer/oh-my-posh

class OhMyPosh < Formula
  desc "Prompt theme engine for any shell"
  homepage "https://ohmyposh.dev"
  license "MIT"
  version "31.9.1"

  depends_on :macos

  if Hardware::CPU.intel?
    url "https://gh-proxy.com/https://github.com/JanDeDobbeleer/oh-my-posh/releases/download/v31.9.1/posh-darwin-amd64", using: :nounzip
    sha256 "031969e78794c33a5394f8bb028210fa88e534b44565729f595c32c20f69d38b"
  elsif Hardware::CPU.arm?
    url "https://gh-proxy.com/https://github.com/JanDeDobbeleer/oh-my-posh/releases/download/v31.9.1/posh-darwin-arm64", using: :nounzip
    sha256 "fbe1c3eb65ad9e10311dbb451c82aa9c7926dbc015dc714d02d89d3e5ae4a48d"
  end

  def install
    if Hardware::CPU.intel?
      bin.install "posh-darwin-amd64" => "oh-my-posh"
    elsif Hardware::CPU.arm?
      bin.install "posh-darwin-arm64" => "oh-my-posh"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/oh-my-posh version")
  end
end
