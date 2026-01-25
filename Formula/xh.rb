# References: https://github.com/Homebrew/homebrew-core/blob/d1828e15baf4350467cac0b53050ad2d337229ed/Formula/x/xh.rb

class Xh < Formula
  desc "Friendly and fast tool for sending HTTP requests"
  homepage "https://github.com/ducaale/xh"
  license "MIT"
  version "0.25.3"

  depends_on :macos

  if Hardware::CPU.intel?
    url "https://ghfast.top/https://github.com/ducaale/xh/releases/download/v0.25.3/xh-v0.25.3-x86_64-apple-darwin.tar.gz"
    sha256 "ef0bd8fe2752abd84202d0b0ac5d4943712ce3c464d70a679b140ca2a0a475cf"
  elsif Hardware::CPU.arm?
    url "https://ghfast.top/https://github.com/ducaale/xh/releases/download/v0.25.3/xh-v0.25.3-aarch64-apple-darwin.tar.gz"
    sha256 "3886af1df744a44f6f8da37d51e3f733c14b35aeb3f46828ee528970ad708951"
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
