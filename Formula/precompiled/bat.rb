# References: https://github.com/Homebrew/homebrew-core/blob/d1828e15baf4350467cac0b53050ad2d337229ed/Formula/b/bat.rb
# @repo https://github.com/sharkdp/bat

class Bat < Formula
  desc "Clone of cat(1) with syntax highlighting and Git integration"
  homepage "https://github.com/sharkdp/bat"
  license any_of: ["Apache-2.0", "MIT"]
  version "0.26.1"

  depends_on :macos

  if Hardware::CPU.intel?
    url "https://gh-proxy.com/https://github.com/sharkdp/bat/releases/download/v0.26.1/bat-v0.26.1-x86_64-apple-darwin.tar.gz"
    sha256 "830d63b0bba1fa040542ec569e3cf77f60d3356b9de75116a344b061e0894245"
  elsif Hardware::CPU.arm?
    url "https://gh-proxy.com/https://github.com/sharkdp/bat/releases/download/v0.26.1/bat-v0.26.1-aarch64-apple-darwin.tar.gz"
    sha256 "e30beff26779c9bf60bb541e1d79046250cb74378f2757f8eb250afddb19e114"
  end

  def install
    bin.install "bat"
    man1.install "bat.1"
    generate_completions_from_executable(bin/"bat", "--completion")
  end

  test do
    system "#{bin}/bat --version"
  end
end
