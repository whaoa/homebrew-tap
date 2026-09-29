# https://github.com/Homebrew/homebrew-core/blob/7d891c3a640b7bcae6f66eecd02e7e3203d8f73d/Formula/m/mise.rb
# @repo https://github.com/jdx/mise

class Mise < Formula
  desc "Polyglot runtime manager (asdf rust clone)"
  homepage "https://mise.jdx.dev/"
  license "MIT"
  version "2026.9.17"

  depends_on :macos

  depends_on "whaoa/tap/usage"

  if Hardware::CPU.intel?
    url "https://gh-proxy.com/https://github.com/jdx/mise/releases/download/v2026.9.17/mise-v2026.9.17-macos-x64.tar.gz"
    sha256 "b287fd5edcbe5a488a7b63d88b48ec54b9bfeb2df9862a51ee889009444c6f5f"
  elsif Hardware::CPU.arm?
    url "https://gh-proxy.com/https://github.com/jdx/mise/releases/download/v2026.9.17/mise-v2026.9.17-macos-arm64.tar.gz"
    sha256 "63deaba3321800014feb6a92f1fed38680edf8deccbe972beebcdae7b67f3172"
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
