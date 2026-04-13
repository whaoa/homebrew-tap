# References: https://github.com/Homebrew/homebrew-core/blob/f339bdcdc1c6f9bbf3341866044cf41bc8814fed/Formula/f/fastfetch.rb
# @repo https://github.com/fastfetch-cli/fastfetch

class Fastfetch < Formula
  desc "Like neofetch, but much faster because written mostly in C"
  homepage "https://github.com/fastfetch-cli/fastfetch"
  license "MIT"
  version "2.61.0"

  depends_on :macos

  if Hardware::CPU.intel?
    url "https://gh-proxy.com/https://github.com/fastfetch-cli/fastfetch/releases/download/2.61.0/fastfetch-macos-amd64.tar.gz"
    sha256 "d5b463a174f3965382c3e8b9ad7790fe12137c300b388ba566c275f8844b6043"
  elsif Hardware::CPU.arm?
    url "https://gh-proxy.com/https://github.com/fastfetch-cli/fastfetch/releases/download/2.61.0/fastfetch-macos-aarch64.tar.gz"
    sha256 "f6b96f24b339b9d28fd3cc5a64995376966b070aa52b5eb33f15963019bca9e6"
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
