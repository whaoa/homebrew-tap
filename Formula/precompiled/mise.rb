# https://github.com/Homebrew/homebrew-core/blob/7d891c3a640b7bcae6f66eecd02e7e3203d8f73d/Formula/m/mise.rb
# @repo https://github.com/jdx/mise

class Mise < Formula
  desc "Polyglot runtime manager (asdf rust clone)"
  homepage "https://mise.jdx.dev/"
  license "MIT"
  version "2026.5.18"

  depends_on :macos

  depends_on "whaoa/tap/usage"

  if Hardware::CPU.intel?
    url "https://gh-proxy.com/https://github.com/jdx/mise/releases/download/v2026.5.18/mise-v2026.5.18-macos-x64.tar.gz"
    sha256 "1e202d6a4dbba53b395cebe8227f74c31d3e7641328189f1ec141cd4460215d9"
  elsif Hardware::CPU.arm?
    url "https://gh-proxy.com/https://github.com/jdx/mise/releases/download/v2026.5.18/mise-v2026.5.18-macos-arm64.tar.gz"
    sha256 "5a33a37924af58b0e6e983b69447b90a4e1f33f4ee503600a943d99f6c08b2df"
  end

  def install
    bin.install "bin/mise"
    generate_completions_from_executable(bin/"mise", "completion")
    man1.install "man/man1/mise.1"
  end

  test do
    system bin/"mise", "settings", "set", "experimental", "true"
    system bin/"mise", "use", "go@1.23"
    assert_match "1.23", shell_output("#{bin}/mise exec -- go version")
  end
end
