# https://github.com/Homebrew/homebrew-core/blob/3b1fc6ba86270b70f4cea372e21355816fcdbc1a/Formula/s/starship.rb
# @repo https://github.com/starship/starship

class Starship < Formula
  desc "Cross-shell prompt for astronauts"
  homepage "https://starship.rs/"
  license "ISC"
  version "1.25.1"

  depends_on :macos

  if Hardware::CPU.intel?
    url "https://gh-proxy.com/https://github.com/starship/starship/releases/download/v1.25.1/starship-x86_64-apple-darwin.tar.gz"
    sha256 "f86fbe7a3b9f262bcf34ca61e9e996243da511c5500dcd81a1e4daa542869276"
  elsif Hardware::CPU.arm?
    url "https://gh-proxy.com/https://github.com/starship/starship/releases/download/v1.25.1/starship-aarch64-apple-darwin.tar.gz"
    sha256 "1062a2363489b9335529b83204472f02633c08fc3609f1b325be5eba36feb631"
  end

  def install
    bin.install "starship"
    generate_completions_from_executable(bin/"starship", "completions")
  end

  test do
    ENV["STARSHIP_CONFIG"] = ""
    assert_equal "[1;32m❯[0m ", shell_output("#{bin}/starship module character")
  end
end
