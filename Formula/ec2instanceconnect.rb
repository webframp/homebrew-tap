class Ec2instanceconnect < Formula
  include Language::Python::Virtualenv

  desc "All-in-one client for EC2 Instance Connect"
  homepage "https://github.com/aws/aws-ec2-instance-connect-cli"
  url "https://files.pythonhosted.org/packages/05/cc/2a22104b26ec7c1644f4c2394f33c9f94d4d00956af8958174700911fd82/ec2instanceconnectcli-1.0.2.tar.gz"
  sha256 "55a0b20a71214b1d48ddb368e7ba742177fddbeb4ed6d4fb292517cced48c885"
  head "https://github.com/aws/aws-ec2-instance-connect-cli.git", :branch => "master"

  depends_on "python@3.10"
  depends_on "openssl@1.1"
  depends_on "rust" => :build

  resource "botocore" do
    url "https://files.pythonhosted.org/packages/1c/a0/0d25fee1a812922c4f2eb5ffa432855941122aaacdd993b776269c341b97/botocore-1.26.8.tar.gz"
    sha256 "e786722cb14de7319331cc55e9092174de66a768559700ef656d05ff41b3e24f"
  end

  resource "cffi" do
    url "https://files.pythonhosted.org/packages/00/9e/92de7e1217ccc3d5f352ba21e52398372525765b2e0c4530e6eb2ba9282a/cffi-1.15.0.tar.gz"
    sha256 "920f0d66a896c2d99f0adbb391f990a84091179542c205fa53ce5787aff87954"
  end

  resource "cryptography" do
    url "https://files.pythonhosted.org/packages/51/05/bb2b681f6a77276fc423d04187c39dafdb65b799c8d87b62ca82659f9ead/cryptography-37.0.2.tar.gz"
    sha256 "f224ad253cc9cea7568f49077007d2263efa57396a2f2f78114066fd54b5c68e"
  end

  resource "jmespath" do
    url "https://files.pythonhosted.org/packages/06/7e/44686b986ef9ca6069db224651baaa8300b93af2a085a5b135997bf659b3/jmespath-1.0.0.tar.gz"
    sha256 "a490e280edd1f57d6de88636992d05b71e97d69a26a19f058ecf7d304474bf5e"
  end

  resource "pycparser" do
    url "https://files.pythonhosted.org/packages/5e/0b/95d387f5f4433cb0f53ff7ad859bd2c6051051cebbb564f139a999ab46de/pycparser-2.21.tar.gz"
    sha256 "e644fdec12f7872f86c58ff790da456218b10f863970249516d60a5eaca77206"
  end

  resource "python-dateutil" do
    url "https://files.pythonhosted.org/packages/4c/c4/13b4776ea2d76c115c1d1b84579f3764ee6d57204f6be27119f13a61d0a9/python-dateutil-2.8.2.tar.gz"
    sha256 "0123cacc1627ae19ddf3c27a5de5bd67ee4586fbdd6440d9748f8abb483d3e86"
  end

  resource "six" do
    url "https://files.pythonhosted.org/packages/71/39/171f1c67cd00715f190ba0b100d606d440a28c93c7714febeca8b79af85e/six-1.16.0.tar.gz"
    sha256 "1e61c37477a1626458e36f7b1d82aa5c9b094fa4802892072e49de9c60c4c926"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/1b/a5/4eab74853625505725cefdf168f48661b2cd04e7843ab836f3f63abf81da/urllib3-1.26.9.tar.gz"
    sha256 "aabaf16477806a5e1dd19aa41f8c2b7950dd3c746362d7e3223dbe6de6ac448e"
  end

  def install
    virtualenv_install_with_resources

    bin.install_symlink libexec/"bin/mssh"
    bin.install_symlink libexec/"bin/msftp"
  end

  test do
    assert_match 'mssh [-t instance_id] ', shell_output("#{bin}/mssh -h")
    assert_match 'msftp [-u aws_profile]', shell_output("#{bin}/msftp -h")
  end
end
