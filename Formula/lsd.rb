# References: https://github.com/Homebrew/homebrew-core/blob/d1828e15baf4350467cac0b53050ad2d337229ed/Formula/l/lsd.rb

class Lsd < Formula
  desc "Clone of ls with colorful output, file type icons, and more"
  homepage "https://github.com/lsd-rs/lsd"
  license "Apache-2.0"
  version "1.2.0"

  depends_on :macos

  if Hardware::CPU.intel?
    url "https://ghfast.top/https://github.com/lsd-rs/lsd/releases/download/v1.2.0/lsd-v1.2.0-x86_64-apple-darwin.tar.gz"
    sha256 "00d3c50551b270bbdf7da97816e5ba7f5fd10294cd310165f7f8b5523e738b9c"
  elsif Hardware::CPU.arm?
    url "https://ghfast.top/https://github.com/lsd-rs/lsd/releases/download/v1.2.0/lsd-v1.2.0-aarch64-apple-darwin.tar.gz"
    sha256 "9e34a5d392ff913302098aad0543dafa1883c531eaf229b82f086c3fca675e3e"
  end

  def install
    bin.install "lsd"
    bash_completion.install "autocomplete/lsd.bash-completion" => "lsd"
    fish_completion.install "autocomplete/lsd.fish"
    zsh_completion.install "autocomplete/_lsd"
    pwsh_completion.install "autocomplete/_lsd.ps1"
    man1.install "lsd.1"
  end

  test do
    system bin/"lsd", "--version"
  end
end
