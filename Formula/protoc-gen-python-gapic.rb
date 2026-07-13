class ProtocGenPythonGapic < Formula
  include Language::Python::Virtualenv

  desc "GAPIC protoc plugin for Python (protoc-gen-python_gapic)"
  homepage "https://github.com/the-protobuf-project/gapic"
  url "https://github.com/the-protobuf-project/gapic/releases/download/py-v1.37.0/gapic_generator-1.37.0.tar.gz"
  sha256 "5876b2b7dfa499ec0f999f11d7a6bc3886d0b3fd7b9622d3a7e858a797231ed4"
  license "Apache-2.0"
  version "1.37.0"

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
