# https://github.com/Homebrew/homebrew-core/blob/7d891c3a640b7bcae6f66eecd02e7e3203d8f73d/Formula/m/mise.rb
# @repo https://github.com/jdx/mise

class Mise < Formula
  desc "Polyglot runtime manager (asdf rust clone)"
  homepage "https://mise.jdx.dev/"
  license "MIT"
  version "2026.4.28"

  depends_on :macos

  if Hardware::CPU.intel?
    url "https://gh-proxy.com/https://github.com/jdx/mise/releases/download/v2026.4.28/mise-v2026.4.28-macos-x64.tar.gz"
    sha256 "c590f28b9e04085df73736fdfc4a1f6eef3b866d730c7a061aa2df46c8cf1c66"
  elsif Hardware::CPU.arm?
    url "https://gh-proxy.com/https://github.com/jdx/mise/releases/download/v2026.4.28/mise-v2026.4.28-macos-arm64.tar.gz"
    sha256 "0b226fa0b96f50bf41a35f96e8ef166e3d7a834ab7bfad4f3f1a12ff928363f4"
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
