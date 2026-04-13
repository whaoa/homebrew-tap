# References: https://github.com/Homebrew/homebrew-core/blob/d89a759a2b2e3bfd35c1dc39eb4aa549dc14f078/Formula/g/gh.rb

class Gh < Formula
  desc "GitHub command-line tool"
  homepage "https://cli.github.com/"
  license "MIT"
  version "2.86.0"

  depends_on :macos

  if Hardware::CPU.intel?
    url "https://ghfast.top/https://github.com/cli/cli/releases/download/v2.86.0/gh_2.86.0_macOS_amd64.zip"
    sha256 "ced7094d05702eb54a63542abd8a1dc570b7e5ae94951844eb1626ba74bc2c60"
  elsif Hardware::CPU.arm?
    url "https://ghfast.top/https://github.com/cli/cli/releases/download/v2.86.0/gh_2.86.0_macOS_arm64.zip"
    sha256 "bde753978a352c5ae6c4abec47334d516e82807af20c9dbbd45507a5a0aedaaa"
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
