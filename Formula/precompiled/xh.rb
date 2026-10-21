# References: https://github.com/Homebrew/homebrew-core/blob/d1828e15baf4350467cac0b53050ad2d337229ed/Formula/x/xh.rb
# @repo https://github.com/ducaale/xh

class Xh < Formula
  desc "Friendly and fast tool for sending HTTP requests"
  homepage "https://github.com/ducaale/xh"
  license "MIT"
  version "0.26.2"

  depends_on :macos

  if Hardware::CPU.intel?
    url "https://gh-proxy.com/https://github.com/ducaale/xh/releases/download/v0.26.2/xh-v0.26.2-x86_64-apple-darwin.tar.gz"
    sha256 "1f19ae1a2f411c58bd6943c638472cd5c4179ed019fe4f786e524b27da4c14a2"
  elsif Hardware::CPU.arm?
    url "https://gh-proxy.com/https://github.com/ducaale/xh/releases/download/v0.26.2/xh-v0.26.2-aarch64-apple-darwin.tar.gz"
    sha256 "cc5739d061a8469d0011ca0ab92d4a5cd726cc56f0ef30108953b119f54d0719"
  end

  def install
    bin.install "xh"
    bin.install_symlink bin/"xh" => "xhs"

    man1.install "doc/xh.1"
    bash_completion.install "completions/xh.bash" => "xh"
    fish_completion.install "completions/xh.fish"
    zsh_completion.install "completions/_xh"
    pwsh_completion.install "completions/_xh.ps1"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/xh --version")
  end
end
