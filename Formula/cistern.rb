class Cistern < Formula
  desc "A top-like utility for Unix to monitor Continuous Integration pipelines from the command line. Current integrations include GitLab, Azure DevOps, Travis CI, AppVeyor and CircleCI."
  homepage "https://github.com/nbedos/cistern"
  url "https://github.com/nbedos/cistern/archive/0.1.2.tar.gz"
  sha256 "6402f352998bfcd3b8700e9771b77ff0bd53197ad035f2b7c615ee65ef874169"

  depends_on "go" => :build

  def install
    system "go", "build", "-o", "#{bin}/#{name}"
  end

  test do
    output = shell_output("#{bin}/cistern -h")
    assert_match "citop undefined", output
  end
end
