# References: https://github.com/Homebrew/homebrew-core/blob/f339bdcdc1c6f9bbf3341866044cf41bc8814fed/Formula/f/fastfetch.rb

class Fastfetch < Formula
  desc "Like neofetch, but much faster because written mostly in C"
  homepage "https://github.com/fastfetch-cli/fastfetch"
  license "MIT"
  version "2.58.0"

  depends_on :macos

  if Hardware::CPU.intel?
    url "https://ghfast.top/https://github.com/fastfetch-cli/fastfetch/releases/download/2.58.0/fastfetch-macos-amd64.tar.gz"
    sha256 "71e330959d9ad38d9391406ca1f9e1d56b38fed22c31f74719ba2aa39fbb602d"
  elsif Hardware::CPU.arm?
    url "https://ghfast.top/https://github.com/fastfetch-cli/fastfetch/releases/download/2.58.0/fastfetch-macos-aarch64.tar.gz"
    sha256 "b106964696e4c79980313ef3e81dc5c1ac1d9fc9d8e0a1077f95593f3afcea1f"
  end

  def install
    bin.install Dir["usr/bin/*"]
    bash_completion.install "usr/share/bash-completion/completions/fastfetch"
    zsh_completion.install "usr/share/zsh/site-functions/_fastfetch"
    fish_completion.install "usr/share/fish/vendor_completions.d/fastfetch.fish"
    man1.install "usr/share/man/man1/fastfetch.1"
  end

  test do
    assert_match "fastfetch", shell_output("#{bin}/fastfetch --version")
    assert_match "OS", shell_output("#{bin}/fastfetch --structure OS --pipe")
  end
end
