require "language/haskell"

class Dhall < Formula
  include Language::Haskell::Cabal

  desc "Interpreter for the Dhall language"
  homepage "https://dhall-lang.org/"
  url "https://hackage.haskell.org/package/dhall-1.21.0/dhall-1.21.0.tar.gz"
  sha256 "9b22cc6f7694ef2f5d5d6fa66727044622b9905b2a9da0cdf376c75ad3b9df0e"

  bottle do
    cellar :any_skip_relocation
    sha256 "257bed839ea53d14054be3fefa0e35b78b3b807e59f88eb84013e9aa0c364a09" => :mojave
    sha256 "ce895046f75e368da7c5e750bfdb32d487307a4ceecef3aa11febfa48524a28c" => :high_sierra
    sha256 "ee166bcae7c837e83ba18756321da6df166906b740403353432834363fff3bcf" => :sierra
  end

  depends_on "cabal-install" => :build
  depends_on "ghc" => :build

  def install
    install_cabal_package
  end

  test do
    assert_match "{=}", pipe_output("#{bin}/dhall format", "{ = }", 0)
    assert_match "8", pipe_output("#{bin}/dhall normalize", "(\\(x : Natural) -> x + 3) 5", 0)
    assert_match "∀(x : Natural) → Natural", pipe_output("#{bin}/dhall type", "\\(x: Natural) -> x + 3", 0)
  end
end
