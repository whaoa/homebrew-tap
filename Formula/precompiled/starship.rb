# https://github.com/Homebrew/homebrew-core/blob/3b1fc6ba86270b70f4cea372e21355816fcdbc1a/Formula/s/starship.rb
# @repo https://github.com/starship/starship

class Starship < Formula
  desc "Cross-shell prompt for astronauts"
  homepage "https://starship.rs/"
  license "ISC"
  version "1.24.2"

  depends_on :macos

  if Hardware::CPU.intel?
    url "https://gh-proxy.com/https://github.com/starship/starship/releases/download/v1.24.2/starship-x86_64-apple-darwin.tar.gz"
    sha256 "237beb10cc970c4361536e9f9f434dfed755f8282c5cd951b6a7e3fcbda8e779"
  elsif Hardware::CPU.arm?
    url "https://gh-proxy.com/https://github.com/starship/starship/releases/download/v1.24.2/starship-aarch64-apple-darwin.tar.gz"
    sha256 "d3a0da21374962625a2ee992110979bc1fa33424d7b6aea58a70405e26544fd9"
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
