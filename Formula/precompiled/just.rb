# References: https://github.com/Homebrew/homebrew-core/blob/d1828e15baf4350467cac0b53050ad2d337229ed/Formula/j/just.rb
# @repo https://github.com/casey/just

class Just < Formula
  desc "Handy way to save and run project-specific commands"
  homepage "https://github.com/casey/just"
  license "CC0-1.0"
  version "1.49.0"

  depends_on :macos

  if Hardware::CPU.intel?
    url "https://gh-proxy.com/https://github.com/casey/just/releases/download/1.49.0/just-1.49.0-x86_64-apple-darwin.tar.gz"
    sha256 "e0b83a9352952ab25e5cf13f6cb03dd1872416e5d89388b56d6ca58f11b0a3a8"
  elsif Hardware::CPU.arm?
    url "https://gh-proxy.com/https://github.com/casey/just/releases/download/1.49.0/just-1.49.0-aarch64-apple-darwin.tar.gz"
    sha256 "d21b20df01ec9b9762b0ef08e56ae8dccf3738770edeafa8d2b3a750aee06d78"
  end

  def install
    bin.install "just"
    generate_completions_from_executable(bin/"just", "--completions")
    man1.install "just.1"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/just --version")
  end
end
