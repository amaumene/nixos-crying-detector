{ lib, buildPythonPackage, fetchPypi }:

buildPythonPackage rec {
  pname = "nvidia-ml-py3";
  version = "7.352.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "390f02919ee9d73fe63a98c73101061a6b37fa694a793abf56673320f1f51277";
  };

  meta = with lib; {
    homepage = "http://www.nvidia.com/";
    description = "Python bindings to the NVIDIA Management Library";
    license = licenses.bsd3;
    maintainers = with maintainers; [ amaumene ];
  };
}
