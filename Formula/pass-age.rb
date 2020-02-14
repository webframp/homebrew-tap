class PassAge < Formula
  desc "A pass extension that can show you how long you are using a certain password."
  homepage "https://www.passwordstore.org"
  url "https://github.com/tijn/pass-age/archive/master.zip"
  sha256 "e5f60acebf08d90548a340ae6b11e4f650f3d3e83bdf58fce29695036cd0db1f"
  version "0.1.0"

  depends_on "gnupg" => :test
  depends_on "pass"

  def install
    (lib/"password-store/extensions").install "age.bash"
    (lib/"password-store/extensions").install "ages.bash"
  end

  # TODO
  # write some sort of test function similar to:
  # https://raw.githubusercontent.com/Homebrew/homebrew-core/master/Formula/pass.rb
  # test do
  #   (testpath/"batch.gpg").write <<~EOS
  #     Key-Type: RSA
  #     Key-Length: 2048
  #     Subkey-Type: RSA
  #     Subkey-Length: 2048
  #     Name-Real: Testing
  #     Name-Email: testing@foo.bar
  #     Expire-Date: 1d
  #     %no-protection
  #     %commit
  #   EOS
  #   begin
  #     system Formula["gnupg"].opt_bin/"gpg", "--batch", "--gen-key", "batch.gpg"
  #     system "pass", "init", "Testing"
  #     system "pass", "generate", "Email/testing@foo.bar", "15"
  #     cmd = "pass age Email/testing@foo.bar"
  #     Open3.popen3({"PASSWORD_STORE_ENABLE_EXTENSIONS" => "true",
  #                   "PASSWORD_STORE_EXTENSIONS_DIR" => "/usr/local/lib/password-store/extensions"}, "#{cmd}") do |stdin, stdout, stderr|
  #       puts stdout.read()
  #       puts stderr.read()
  #       assert_match "seconds ago", stdout.read()
  #     end
  #   ensure
  #     system Formula["gnupg"].opt_bin/"gpgconf", "--kill", "gpg-agent"
  #   end
  # end
end
