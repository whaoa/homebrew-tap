# https://github.com/Homebrew/homebrew-core/blob/7d891c3a640b7bcae6f66eecd02e7e3203d8f73d/Formula/m/mise.rb
# @repo https://github.com/jdx/mise

class Mise < Formula
  desc "Polyglot runtime manager (asdf rust clone)"
  homepage "https://mise.jdx.dev/"
  license "MIT"
  version "2026.10.17"

  depends_on :macos

  depends_on "whaoa/tap/usage"

  if Hardware::CPU.intel?
    url "https://gh-proxy.com/https://github.com/jdx/mise/releases/download/v2026.10.17/mise-v2026.10.17-macos-x64.tar.gz"
    sha256 "e42418100e2f781f9be00b9feaa60378e77551741faececc2bf360992c5410c8"
  elsif Hardware::CPU.arm?
    url "https://gh-proxy.com/https://github.com/jdx/mise/releases/download/v2026.10.17/mise-v2026.10.17-macos-arm64.tar.gz"
    sha256 "d7c50c1683524a764260986ccc9c41c0de5e1fcd491714b5640b657b76781af6"
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
