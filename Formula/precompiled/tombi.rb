# https://github.com/Homebrew/homebrew-core/blob/6182eb4c55d3aec45ca2446b93de6e3bf87cefca/Formula/t/tombi.rb
# @repohttps://github.com/tombi-toml/tombi

class Tombi < Formula
  desc "TOML formatter, linter and language server"
  homepage "https://github.com/tombi-toml/tombi"
  license "MIT"
  version "1.1.0"

  depends_on :macos

  if Hardware::CPU.intel?
    url "https://gh-proxy.com/https://github.com/tombi-toml/tombi/releases/download/v1.1.0/tombi-cli-1.1.0-x86_64-apple-darwin.tar.gz"
    sha256 "0180797ef983cc56d33a0d0c22b46d37ba8b2f5718be494556d4cdec0116591f"
  elsif Hardware::CPU.arm?
    url "https://gh-proxy.com/https://github.com/tombi-toml/tombi/releases/download/v1.1.0/tombi-cli-1.1.0-aarch64-apple-darwin.tar.gz"
    sha256 "9adc2c6ac821c758342c12aba18c394f404035483fd41b46a422da38a70e3ad8"
  end

  def install
    bin.install "tombi"
    generate_completions_from_executable(bin/"tombi", "completion", shells: [:bash, :zsh, :fish, :pwsh])
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/tombi --version")

    require "open3"

    json = <<~JSON
      {
        "jsonrpc": "2.0",
        "id": 1,
        "method": "initialize",
        "params": {
          "rootUri": null,
          "capabilities": {}
        }
      }
    JSON

    Open3.popen3(bin/"tombi", "lsp") do |stdin, stdout|
      stdin.write "Content-Length: #{json.size}\r\n\r\n#{json}"
      sleep 1
      assert_match(/^Content-Length: \d+/i, stdout.readline)
    end
  end
end
