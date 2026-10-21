# https://github.com/Homebrew/homebrew-core/blob/5fa6e34fd59bc44736b8625d0fd31399f038e86b/Formula/i/ipatool.rb
# @repo https://github.com/majd/ipatool

class Ipatool < Formula
  desc "CLI tool for searching and downloading app packages from the iOS App Store"
  homepage "https://github.com/majd/ipatool"
  license "MIT"
  version "2.7.0"

  depends_on :macos

  if Hardware::CPU.intel?
    url "https://gh-proxy.com/https://github.com/majd/ipatool/releases/download/v2.7.0/ipatool-2.7.0-macos-amd64.tar.gz"
    sha256 "05f48994d8b3cfefe7ea1172a0ac0b28715888e9df0af38cf3e490d2ed592263"
  elsif Hardware::CPU.arm?
    url "https://gh-proxy.com/https://github.com/majd/ipatool/releases/download/v2.7.0/ipatool-2.7.0-macos-arm64.tar.gz"
    sha256 "5ae100d4520cf4b3f4374239e5925a9ad9a8dc02abc16bae27479e7ae99aca33"
  end

  def install
    if Hardware::CPU.intel?
      bin.install "ipatool-2.7.0-macos-amd64" => "ipatool"
    elsif Hardware::CPU.arm?
      bin.install "ipatool-2.7.0-macos-arm64" => "ipatool"
    end
    generate_completions_from_executable(bin/"ipatool", shell_parameter_format: :cobra)
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ipatool --version")

    output = shell_output("#{bin}/ipatool auth info 2>&1", 1)
    assert_match "failed to get account", output
  end
end
