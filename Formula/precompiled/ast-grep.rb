# https://github.com/Homebrew/homebrew-core/blob/c1599cc35573823428e3843ddc79eb1572406ac8/Formula/a/ast-grep.rb
# @repo https://github.com/ast-grep/ast-grep

class AstGrep < Formula
  desc "Code searching, linting, rewriting"
  homepage "https://github.com/ast-grep/ast-grep"
  license "MIT"
  version "0.43.0"

  depends_on :macos

  url "https://gh-proxy.com/https://github.com/ast-grep/ast-grep/releases/download/0.43.0/app-x86_64-apple-darwin.zip"
  sha256 "6d703090b106747b2f56086b6ccc7e798fe78bcae70257aa20519b220153555b"

  def install
    bin.install "ast-grep"
    bin.install "sg"
    generate_completions_from_executable(bin/"ast-grep", "completions", shells: [:bash, :zsh, :fish, :pwsh])
  end

  test do
    (testpath/"hi.js").write("console.log('it is me')")
    system bin/"ast-grep", "run", "-l", "js", "-p console.log", (testpath/"hi.js")

    assert_match version.to_s, shell_output("#{bin}/ast-grep --version")
  end
end
