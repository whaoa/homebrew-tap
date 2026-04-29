# References: https://github.com/Homebrew/homebrew-core/blob/f339bdcdc1c6f9bbf3341866044cf41bc8814fed/Formula/f/fastfetch.rb
# @repo https://github.com/fastfetch-cli/fastfetch

class Fastfetch < Formula
  desc "Like neofetch, but much faster because written mostly in C"
  homepage "https://github.com/fastfetch-cli/fastfetch"
  license "MIT"
  version "2.62.1"

  depends_on :macos

  if Hardware::CPU.intel?
    url "https://gh-proxy.com/https://github.com/fastfetch-cli/fastfetch/releases/download/2.62.1/fastfetch-macos-amd64.tar.gz"
    sha256 "742a6daddcbee5682904824eed438b96676190139d58cb6bdabdcca9a07ae0d0"
  elsif Hardware::CPU.arm?
    url "https://gh-proxy.com/https://github.com/fastfetch-cli/fastfetch/releases/download/2.62.1/fastfetch-macos-aarch64.tar.gz"
    sha256 "751f61d5c60b21c4a2f88ac5bf295ed3ff42ba7d3333bc7f08d26d2d5d3455c0"
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
