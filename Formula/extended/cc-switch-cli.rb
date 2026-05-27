# @repo https://github.com/SaladDay/cc-switch-cli

class CcSwitchCli < Formula
  desc "A cross-platform CLI All-in-One assistant tool for Claude Code, Codex & Gemini CLI."
  homepage "https://github.com/SaladDay/cc-switch-cli"
  license "MIT"
  version "5.7.0"

  depends_on :macos

  if Hardware::CPU.intel?
    url "https://gh-proxy.com/https://github.com/SaladDay/cc-switch-cli/releases/download/v5.7.0/cc-switch-cli-darwin-x64.tar.gz"
    sha256 "7ef3ac9fe0c29a39e405749ed028a6aca8b011d4fed4fc035788ae678b4675b4"
  elsif Hardware::CPU.arm?
    url "https://gh-proxy.com/https://github.com/SaladDay/cc-switch-cli/releases/download/v5.7.0/cc-switch-cli-darwin-arm64.tar.gz"
    sha256 "1f68d640a4304fc440f7d6ea65c2af8444b3189bc71f4a15babcd215b29fb044"
  end

  def install
    chmod "+x", "cc-switch"
    bin.install "cc-switch"
    generate_completions_from_executable(bin/"cc-switch", "completions")
  end

  test do
    system bin/"mise", "settings", "set", "experimental", "true"
    system bin/"mise", "use", "go@1.23"
    assert_match "1.23", shell_output("#{bin}/mise exec -- go version")
  end
end
