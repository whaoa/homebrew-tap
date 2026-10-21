# References: https://github.com/Homebrew/homebrew-core/blob/d89a759a2b2e3bfd35c1dc39eb4aa549dc14f078/Formula/g/gh.rb
# @repo https://github.com/cli/cli

class Gh < Formula
  desc "GitHub command-line tool"
  homepage "https://cli.github.com/"
  license "MIT"
  version "2.102.1"

  depends_on :macos

  if Hardware::CPU.intel?
    url "https://gh-proxy.com/https://github.com/cli/cli/releases/download/v2.102.1/gh_2.102.1_macOS_amd64.zip"
    sha256 "91c5fbd493274b545b03ef32a89c2a21238393c0c0b1108210967199b3230d9d"
  elsif Hardware::CPU.arm?
    url "https://gh-proxy.com/https://github.com/cli/cli/releases/download/v2.102.1/gh_2.102.1_macOS_arm64.zip"
    sha256 "08bfef98b50c553df122bb34ee8dcf415cae7d3b108891488964a0df07aa2aeb"
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
