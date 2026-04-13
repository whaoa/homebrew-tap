# References: https://github.com/Homebrew/homebrew-core/blob/d89a759a2b2e3bfd35c1dc39eb4aa549dc14f078/Formula/o/oh-my-posh.rb
# @repo https://github.com/JanDeDobbeleer/oh-my-posh

class OhMyPosh < Formula
  desc "Prompt theme engine for any shell"
  homepage "https://ohmyposh.dev"
  license "MIT"
  version "29.10.0"

  depends_on :macos

  if Hardware::CPU.intel?
    url "https://gh-proxy.com/https://github.com/JanDeDobbeleer/oh-my-posh/releases/download/v29.10.0/posh-darwin-amd64", using: :nounzip
    sha256 "817f207bf406b6b71312836b6569ef24398941bfe7a32010398d74ecf84566a7"
  elsif Hardware::CPU.arm?
    url "https://gh-proxy.com/https://github.com/JanDeDobbeleer/oh-my-posh/releases/download/v29.10.0/posh-darwin-arm64", using: :nounzip
    sha256 "4f96de4cf14c083642a78a49686b8ae60eb59b686a117aa4f8e3ec9acdad8ee0"
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
