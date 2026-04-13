# References: https://github.com/Homebrew/homebrew-core/blob/d89a759a2b2e3bfd35c1dc39eb4aa549dc14f078/Formula/o/oh-my-posh.rb

class OhMyPosh < Formula
  desc "Prompt theme engine for any shell"
  homepage "https://ohmyposh.dev"
  license "MIT"
  version "29.1.0"

  depends_on :macos

  if Hardware::CPU.intel?
    url "https://gh-proxy.com/https://github.com/JanDeDobbeleer/oh-my-posh/releases/download/v29.1.0/posh-darwin-amd64", using: :nounzip
    sha256 "b03a429a4415535b9fbeb0256ff0944bbc1205ed24d3dfafe43cac46396e5aaa"
  elsif Hardware::CPU.arm?
    url "https://gh-proxy.com/https://github.com/JanDeDobbeleer/oh-my-posh/releases/download/v29.1.0/posh-darwin-arm64", using: :nounzip
    sha256 "090e5e39302b98e4995a2856c337c41dc938334ef9c50fc007e1ed9d26773c38"
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
