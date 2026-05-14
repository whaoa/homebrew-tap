# https://github.com/Homebrew/homebrew-core/blob/29f35a04a37584f2c50347d98f09416197d69b60/Formula/z/zellij.rb
# @repo https://github.com/zellij-org/zellij

class Zellij < Formula
  desc "Pluggable terminal workspace, with terminal multiplexer as the base feature"
  homepage "https://zellij.dev"
  license "MIT"
  version "0.44.3"

  depends_on :macos

  if Hardware::CPU.intel?
    url "https://gh-proxy.com/https://github.com/zellij-org/zellij/releases/download/v0.44.3/zellij-x86_64-apple-darwin.tar.gz"
    sha256 "59f803faa32cd4e5f316f0dc2d3b7a5530a72553e38ad939286471848a418eeb"
  elsif Hardware::CPU.arm?
    url "https://gh-proxy.com/https://github.com/zellij-org/zellij/releases/download/v0.44.3/zellij-aarch64-apple-darwin.tar.gz"
    sha256 "b6acf83a7739cf5f0f4e9bd47709642d4d98acbbf8c34d4a12c6e706f531da61"
  end

  def install
    bin.install "zellij"
    generate_completions_from_executable(bin/"zellij", "setup", "--generate-completion")
  end

  test do
    assert_match("keybinds", shell_output("#{bin}/zellij setup --dump-config"))
    assert_match("zellij #{version}", shell_output("#{bin}/zellij --version"))
  end
end
