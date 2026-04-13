# References: https://github.com/Homebrew/homebrew-core/blob/d1828e15baf4350467cac0b53050ad2d337229ed/Formula/j/just.rb

class Just < Formula
  desc "Handy way to save and run project-specific commands"
  homepage "https://github.com/casey/just"
  license "CC0-1.0"
  version "1.46.0"

  depends_on :macos

  if Hardware::CPU.intel?
    url "https://gh-proxy.com/https://github.com/casey/just/releases/download/1.46.0/just-1.46.0-x86_64-apple-darwin.tar.gz"
    sha256 "ec54dd60ac876261b7318f1852ef9c0319fede1e5a73c14f56d908a8edf595b8"
  elsif Hardware::CPU.arm?
    url "https://gh-proxy.com/https://github.com/casey/just/releases/download/1.46.0/just-1.46.0-aarch64-apple-darwin.tar.gz"
    sha256 "438eaf6468a115aa7db93e501cc7e3272f453f6b7083be3863adfab546b23358"
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
