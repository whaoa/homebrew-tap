# https://github.com/Homebrew/homebrew-core/blob/5fa6e34fd59bc44736b8625d0fd31399f038e86b/Formula/i/ipatool.rb
# @repo https://github.com/majd/ipatool

class Ipatool < Formula
  desc "CLI tool for searching and downloading app packages from the iOS App Store"
  homepage "https://github.com/majd/ipatool"
  license "MIT"
  version "2.3.1"

  depends_on :macos

  if Hardware::CPU.intel?
    url "https://gh-proxy.com/https://github.com/majd/ipatool/releases/download/v2.3.1/ipatool-2.3.1-macos-amd64.tar.gz"
    sha256 "43a4b0206af94fab2e4a4bf344ff16ac3825b6c733692fcfc0cfd81af93d9df3"
  elsif Hardware::CPU.arm?
    url "https://gh-proxy.com/https://github.com/majd/ipatool/releases/download/v2.3.1/ipatool-2.3.1-macos-arm64.tar.gz"
    sha256 "f2e58e9d3ece196654e7b9dfcc2748cfdfbee4c5009c7f3d840640d8a1136500"
  end

  def install
    if Hardware::CPU.intel?
      bin.install "ipatool-2.3.1-macos-amd64" => "ipatool"
    elsif Hardware::CPU.arm?
      bin.install "ipatool-2.3.1-macos-arm64" => "ipatool"
    end
    generate_completions_from_executable(bin/"ipatool", shell_parameter_format: :cobra)
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ipatool --version")

    output = shell_output("#{bin}/ipatool auth info 2>&1", 1)
    assert_match "failed to get account", output
  end
end
