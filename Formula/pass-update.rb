class PassUpdate < Formula
  desc "Extension for pass that provides an easy flow for updating passwords"
  homepage "https://www.passwordstore.org"
  url "https://github.com/roddhjav/pass-update/releases/download/v2.1/pass-update-2.1.tar.gz"
  sha256 "2b0022102238e022e7ee945b7622f4c270810cda46508084fcb193582aafaf6f"

  depends_on "gnupg" => :test
  depends_on "pass"

  def install
    system "make", "PREFIX=#{prefix}", "BASHCOMPDIR=#{bash_completion}", "install"
  end

  # TODO
  # write some sort of test function similar to:
  # https://raw.githubusercontent.com/Homebrew/homebrew-core/master/Formula/pass-otp.rb
end
