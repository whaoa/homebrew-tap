# https://github.com/Homebrew/homebrew-core/blob/3b1fc6ba86270b70f4cea372e21355816fcdbc1a/Formula/c/chezmoi.rb
# @repo https://github.com/twpayne/chezmoi

class Chezmoi < Formula
  desc "Manage your dotfiles across multiple diverse machines, securely"
  homepage "https://chezmoi.io/"
  license "MIT"
  version "2.70.1"

  depends_on :macos

  if Hardware::CPU.intel?
    url "https://gh-proxy.com/https://github.com/twpayne/chezmoi/releases/download/v2.70.1/chezmoi_2.70.1_darwin_amd64.tar.gz"
    sha256 "36b9b41dd88485afd30c7940398edef3b4757c19e36689f9324012391ea7dbff"
  elsif Hardware::CPU.arm?
    url "https://gh-proxy.com/https://github.com/twpayne/chezmoi/releases/download/v2.70.1/chezmoi_2.70.1_darwin_arm64.tar.gz"
    sha256 "814fd391b755046d9dbe17c1a7e93d7dd725b2842bf9663c08645771f4a92cf1"
  end

  def install
    bin.install "chezmoi"
    bash_completion.install "completions/chezmoi-completion.bash" => "chezmoi"
    fish_completion.install "completions/chezmoi.fish"
    zsh_completion.install "completions/chezmoi.zsh" => "_chezmoi"
    pwsh_completion.install "completions/chezmoi.ps1"
  end

  test do
    # test version to ensure that version number is embedded in binary
    assert_match(/commit [0-9a-f]{40}/, shell_output("#{bin}/chezmoi --version"))
    assert_match "version v#{version}", shell_output("#{bin}/chezmoi --version")
    assert_match "built by #{tap.user}", shell_output("#{bin}/chezmoi --version")

    system bin/"chezmoi", "init"
    assert_path_exists testpath/".local/share/chezmoi"
  end
end
