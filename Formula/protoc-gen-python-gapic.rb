class ProtocGenPythonGapic < Formula
  include Language::Python::Virtualenv

  desc "GAPIC protoc plugin for Python (protoc-gen-python_gapic)"
  homepage "https://github.com/the-protobuf-project/gapic"
  url "https://github.com/the-protobuf-project/gapic/releases/download/py-v1.43.0/gapic_generator-1.43.0.tar.gz"
  sha256 "666e6cf5e783bfefa38fa7ed78be926ee5dc35387c561adee765bf41d1fd1ece"
  license "Apache-2.0"
  version "1.43.0"

  depends_on "python@3.12"

  def install
    venv = virtualenv_create(libexec, "python3.12")
    # Install our published sdist (present in buildpath); deps from PyPI.
    system libexec/"bin/pip", "install", "--find-links=#{buildpath}", "gapic-generator==#{version}"
    bin.install_symlink libexec/"bin/protoc-gen-python_gapic"
  end

  test do
    assert_predicate bin/"protoc-gen-python_gapic", :executable?
  end
end
