# References: https://github.com/Homebrew/homebrew-core/blob/d89a759a2b2e3bfd35c1dc39eb4aa549dc14f078/Formula/g/gh.rb
# @repo https://github.com/cli/cli

class Gh < Formula
  desc "GitHub command-line tool"
  homepage "https://cli.github.com/"
  license "MIT"
  version "2.89.0"

  depends_on :macos

  if Hardware::CPU.intel?
    url "https://gh-proxy.com/https://github.com/cli/cli/releases/download/v2.89.0/gh_2.89.0_macOS_amd64.zip"
    sha256 "862e21cac6a71f81e7cd6e5127e3cd344f8537441ad2db94cd208319dd17b6e9"
  elsif Hardware::CPU.arm?
    url "https://gh-proxy.com/https://github.com/cli/cli/releases/download/v2.89.0/gh_2.89.0_macOS_arm64.zip"
    sha256 "2423d02ec0a2094898c378703a1b28a5846c08700f87461363857cb8cb3fda94"
  end

  def install
    bin.install "bin/gh"
    man1.install buildpath.glob("share/man/man1/gh*.1")
    generate_completions_from_executable(bin/"gh", "completion", "-s")
  end

  test do
    assert_match "gh version #{version}", shell_output("#{bin}/gh --version")
  end
end
