# https://github.com/Homebrew/homebrew-core/blob/ac9b04ce804c3a268dd0ef515b1289a5a886e510/Formula/r/rtk.rb
# @repo https://github.com/rtk-ai/rtk

class Rtk < Formula
  desc "CLI proxy to minimize LLM token consumption"
  homepage "https://www.rtk-ai.app/"
  license "Apache-2.0"
  version "0.42.0"

  depends_on :macos

  if Hardware::CPU.intel?
    url "https://gh-proxy.com/https://github.com/rtk-ai/rtk/releases/download/v0.42.0/rtk-x86_64-apple-darwin.tar.gz"
    sha256 "fc86caa4ffa30d3e71552195106b207181b9bf85c0ebc2db58576e415aa699f4"
  elsif Hardware::CPU.arm?
    url "https://gh-proxy.com/https://github.com/rtk-ai/rtk/releases/download/v0.42.0/rtk-aarch64-apple-darwin.tar.gz"
    sha256 "cddc9cd11cdf80b3342eebaba0e6ab26d9c8dec45295ea44cf98062987185724"
  end

  def install
    bin.install "rtk"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/rtk --version")

    (testpath/"homebrew.txt").write "hello from homebrew\n"
    output = shell_output("#{bin}/rtk ls #{testpath}")
    assert_match "homebrew.txt", output
  end
end
