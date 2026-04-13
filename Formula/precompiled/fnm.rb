# References: https://github.com/Homebrew/homebrew-core/blob/d1828e15baf4350467cac0b53050ad2d337229ed/Formula/f/fnm.rb
# @repo https://github.com/Schniz/fnm

class Fnm < Formula
  desc "Fast and simple Node.js version manager"
  homepage "https://github.com/Schniz/fnm"
  license "GPL-3.0-only"
  version "1.39.0"

  depends_on :macos

  url "https://gh-proxy.com/https://github.com/Schniz/fnm/releases/download/v1.39.0/fnm-macos.zip"
  sha256 "f046483e85c53b3278efe49a3620c8680f22efa58a8dabfd03eafc6b59b31a25"

  def install
    bin.install "fnm"
    generate_completions_from_executable(bin/"fnm", "completions", "--shell")
  end

  test do
    system "#{bin}/fnm --version"
  end
end
