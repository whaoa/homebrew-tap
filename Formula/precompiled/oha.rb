# https://github.com/Homebrew/homebrew-core/blob/4ca1c3e4e7e24fcd48db0028729ac21ab1211c83/Formula/o/oha.rb
# @repo https://github.com/hatoo/oha

class Oha < Formula
  desc "HTTP load generator, inspired by rakyll/hey with tui animation"
  homepage "https://github.com/hatoo/oha/"
  license "MIT"
  version "1.14.0"

  depends_on :macos

  if Hardware::CPU.intel?
    url "https://gh-proxy.com/https://github.com/hatoo/oha/releases/download/v1.14.0/oha-macos-amd64"
    sha256 "86c11bf6c04175cae8a4c8b8b186f17ea27f6bdcaf8e64a05f93f06ebb3b0a59"
  elsif Hardware::CPU.arm?
    url "https://gh-proxy.com/https://github.com/hatoo/oha/releases/download/v1.14.0/oha-macos-arm64"
    sha256 "cb7b57d722caf63092a4ff76cbdbe5310ee0288113dfeaf7ebf97b3ed2b658a3"
  end

  def install
    if Hardware::CPU.intel?
      bin.install "oha-macos-amd64" => "oha"
    elsif Hardware::CPU.arm?
      bin.install "oha-macos-arm64" => "oha"
    end
  end

  test do
    output = "[200] 1 responses"
    assert_match output.to_s, shell_output("#{bin}/oha -n 1 -c 1 --no-tui https://www.google.com")

    assert_match version.to_s, shell_output("#{bin}/oha --version")
  end
end
