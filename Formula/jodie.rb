class YourApp < Formula
  include Language::Python::Virtualenv

  desc "Describe your application in one sentence"
  homepage "https://example.com"
  url "https://example.com/your_app.tar.gz"
  sha256 "sha256sum_of_tarball"
  license "MIT"

  depends_on "python@3.9"

  def install
    virtualenv_install_with_resources
  end

  test do
    system "false" # Replace with a real test
  end
end
