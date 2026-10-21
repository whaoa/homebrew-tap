# https://github.com/Homebrew/homebrew-core/blob/7d891c3a640b7bcae6f66eecd02e7e3203d8f73d/Formula/r/ripgrep.rb
# @repo https://github.com/BurntSushi/ripgrep

class Ripgrep < Formula
  desc "Search tool like grep and The Silver Searcher"
  homepage "https://github.com/BurntSushi/ripgrep"
  license "Unlicense"
  version "15.2.0"
  compatibility_version 1

  depends_on :macos

  if Hardware::CPU.intel?
    url "https://gh-proxy.com/https://github.com/BurntSushi/ripgrep/releases/download/15.2.0/ripgrep-15.2.0-x86_64-apple-darwin.tar.gz"
    sha256 "af7825fcc69a2afc7a7aea55fc9af90e26421d8f20fe59df32e233c0b8a231c1"
  elsif Hardware::CPU.arm?
    url "https://gh-proxy.com/https://github.com/BurntSushi/ripgrep/releases/download/15.2.0/ripgrep-15.2.0-aarch64-apple-darwin.tar.gz"
    sha256 "3750b2e93f37e0c692657da574d7019a101c0084da05a790c83fd335bad973e4"
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
