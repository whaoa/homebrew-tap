# https://github.com/Homebrew/homebrew-core/blob/5fa6e34fd59bc44736b8625d0fd31399f038e86b/Formula/i/ipatool.rb
# @repo https://github.com/majd/ipatool

class Ipatool < Formula
  desc "CLI tool for searching and downloading app packages from the iOS App Store"
  homepage "https://github.com/majd/ipatool"
  license "MIT"
  version "2.3.0"

  depends_on :macos

  if Hardware::CPU.intel?
    url "https://gh-proxy.com/https://github.com/majd/ipatool/releases/download/v2.3.0/ipatool-2.3.0-macos-amd64.tar.gz"
    sha256 "e4386e117cb12e22b41f025b2cce35126a8eb33f4dc6dca6717cfb9d24cec069"
  elsif Hardware::CPU.arm?
    url "https://gh-proxy.com/https://github.com/majd/ipatool/releases/download/v2.3.0/ipatool-2.3.0-macos-arm64.tar.gz"
    sha256 "440a06010073de66296e0cc51387c4c8629f52608bfe2527e5fdd1293d27d3c3"
  end

  def install
    if Hardware::CPU.intel?
      bin.install "ipatool-2.3.0-macos-amd64" => "ipatool"
    elsif Hardware::CPU.arm?
      bin.install "ipatool-2.3.0-macos-arm64" => "ipatool"
    end
    generate_completions_from_executable(bin/"ipatool", shell_parameter_format: :cobra)
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ipatool --version")

    output = shell_output("#{bin}/ipatool auth info 2>&1", 1)
    assert_match "failed to get account", output
  end
end
