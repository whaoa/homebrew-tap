# References: https://github.com/Homebrew/homebrew-core/blob/b625dc120cecbd24a41d921021eed8935cb0a557/Formula/f/fzf.rb
# Repo: https://github.com/junegunn/fzf

class Fzf < Formula
  desc "Command-line fuzzy finder written in Go"
  homepage "https://github.com/junegunn/fzf"
  license "MIT"
  compatibility_version 1
  version "0.72.0"

  depends_on :macos

  uses_from_macos "ncurses"

  if Hardware::CPU.intel?
    url "https://gh-proxy.com/https://github.com/junegunn/fzf/releases/download/v0.72.0/fzf-0.72.0-darwin_amd64.tar.gz"
    sha256 "561c9db95cc1f75c8ad7e1d4461b2da0c8461189041f610ff1205f6303b84634"
  elsif Hardware::CPU.arm?
    url "https://gh-proxy.com/https://github.com/junegunn/fzf/releases/download/v0.72.0/fzf-0.72.0-darwin_arm64.tar.gz"
    sha256 "4cbf87e8e8a342614c1e3e74670ceb18c2af998c4d4d0c379cfee9b520774e90"
  end

  def install
    bin.install "fzf"
  end

  def caveats
    <<~EOS
      To set up shell integration, see:
        https://github.com/junegunn/fzf#setting-up-shell-integration
      To use fzf in Vim, add the following line to your .vimrc:
        set rtp+=#{opt_prefix}
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/fzf --version")

    (testpath/"list").write %w[hello world].join($INPUT_RECORD_SEPARATOR)
    assert_equal "world", pipe_output("#{bin}/fzf -f wld", (testpath/"list").read).chomp
  end
end
