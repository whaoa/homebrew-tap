# https://github.com/Homebrew/homebrew-core/blob/7d891c3a640b7bcae6f66eecd02e7e3203d8f73d/Formula/r/ripgrep.rb
# @repo https://github.com/BurntSushi/ripgrep

class Ripgrep < Formula
  desc "Search tool like grep and The Silver Searcher"
  homepage "https://github.com/BurntSushi/ripgrep"
  license "Unlicense"
  version "15.1.0"
  compatibility_version 1

  depends_on :macos

  if Hardware::CPU.intel?
    url "https://gh-proxy.com/https://github.com/BurntSushi/ripgrep/releases/download/15.1.0/ripgrep-15.1.0-x86_64-apple-darwin.tar.gz"
    sha256 "64811cb24e77cac3057d6c40b63ac9becf9082eedd54ca411b475b755d334882"
  elsif Hardware::CPU.arm?
    url "https://gh-proxy.com/https://github.com/BurntSushi/ripgrep/releases/download/15.1.0/ripgrep-15.1.0-aarch64-apple-darwin.tar.gz"
    sha256 "378e973289176ca0c6054054ee7f631a065874a352bf43f0fa60ef079b6ba715"
  end

  def install
    bin.install "rg"
    bash_completion.install "complete/rg.bash"
    fish_completion.install "complete/rg.fish"
    zsh_completion.install "complete/_rg"
    pwsh_completion.install "complete/_rg.ps1"
    man1.install "doc/rg.1"
  end

  test do
    (testpath/"Hello.txt").write("Hello World!")
    system bin/"rg", "Hello World!", testpath
  end
end
