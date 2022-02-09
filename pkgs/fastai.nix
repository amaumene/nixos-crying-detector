{ lib, buildPythonPackage, fetchPypi,
  pytest-runner,
  nvidia-ml-py3,
  matplotlib,
  torch-rpi4,
  torchvision-rpi4,
  numexpr,
  bottleneck,
  beautifulsoup4,
  pandas,
  fastprogress,
  packaging,
  requests,
  pyyaml
}:


buildPythonPackage rec {
  pname = "fastai";
  version = "1.0.61";

  src = fetchPypi {
    inherit pname version;
    sha256 = "798b7602849cd6ed8791e6871dd4d15f72bf69ae9de7987e730bb65e7a2f938b";
  };

  doCheck = false;
  buildInputs = [
    pytest-runner
  ];

  propagatedBuildInputs = [
    nvidia-ml-py3
    matplotlib
    torch-rpi4
    torchvision-rpi4
    numexpr
    bottleneck
    beautifulsoup4
    pandas
    fastprogress
    packaging
    requests
    pyyaml
  ];

  meta = with lib; {
    homepage = "http://fastai1.fast.ai/";
    description = "fastai simplifies training fast and accurate neural nets using modern best practices";
    license = licenses.asl20;
    maintainers = with maintainers; [ amaumene ];
  };
}
