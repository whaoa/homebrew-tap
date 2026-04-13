# https://github.com/Homebrew/homebrew-core/blob/7d891c3a640b7bcae6f66eecd02e7e3203d8f73d/Formula/s/sd.rb
# @repo https://github.com/chmln/sd

class Sd < Formula
  desc "Intuitive find & replace CLI"
  homepage "https://github.com/chmln/sd"
  license "MIT"
  version "1.1.0"

  depends_on :macos

  if Hardware::CPU.intel?
    url "https://gh-proxy.com/https://github.com/chmln/sd/releases/download/v1.1.0/sd-v1.1.0-x86_64-apple-darwin.tar.gz"
    sha256 "1fca1e9c91813a8aac6821063c923107ba0f66a83309e095edcd3b202f67f97e"
  elsif Hardware::CPU.arm?
    url "https://gh-proxy.com/https://github.com/chmln/sd/releases/download/v1.1.0/sd-v1.1.0-aarch64-apple-darwin.tar.gz"
    sha256 "4bd3c09226376ca0a1d69589c91e86276fae36c5fbaaee669afce583f6682030"
  end

  def install
    bin.install "sd"
    bash_completion.install "completions/sd.bash" => "sd"
    fish_completion.install "completions/sd.fish"
    zsh_completion.install "completions/_sd"
    pwsh_completion.install "completions/_sd.ps1"
    man1.install "sd.1"
  end

  test do
    assert_equal "after", pipe_output("#{bin}/sd before after", "before")
  end
end
