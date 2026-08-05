# https://github.com/Homebrew/homebrew-core/blob/7d891c3a640b7bcae6f66eecd02e7e3203d8f73d/Formula/m/mise.rb
# @repo https://github.com/jdx/mise

class Mise < Formula
  desc "Polyglot runtime manager (asdf rust clone)"
  homepage "https://mise.jdx.dev/"
  license "MIT"
  version "2026.8.2"

  depends_on :macos

  depends_on "whaoa/tap/usage"

  if Hardware::CPU.intel?
    url "https://gh-proxy.com/https://github.com/jdx/mise/releases/download/v2026.8.2/mise-v2026.8.2-macos-x64.tar.gz"
    sha256 "8d2b823965025473057120fe964f16575989df4103c051a8a007fe5bd1e884c4"
  elsif Hardware::CPU.arm?
    url "https://gh-proxy.com/https://github.com/jdx/mise/releases/download/v2026.8.2/mise-v2026.8.2-macos-arm64.tar.gz"
    sha256 "6d7ff3ad671260413d7e9e13c8b4c2d610d7c303751e1d2acd9cda234fbe06cf"
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
