{ pkgs, lib, setuptools, stdenv, buildPythonPackage, typing-extensions }:

buildPythonPackage rec {
  pname = "torch-rpi4";
  version = "1.10.0";

  format = "wheel";

  src = builtins.fetchurl {
    url = https://github.com/KumaTea/pytorch-aarch64/releases/download/v1.10.0/torch-1.10.0-cp39-cp39-manylinux_2_17_aarch64.manylinux2014_aarch64.whl;
    sha256 = "0l3hkjd07pzcnbnlpngzkg0akqcc1vz01vgl1yc48cz29rpzcll3";
  };

  buildInputs = [ stdenv.cc.cc.lib ];

  propagatedBuildInputs = [ setuptools typing-extensions ];

  nativeBuildInputs = [ pkgs.autoPatchelfHook ];  

  meta = with lib; {
    description = "torch";
    homepage = "url torch";
    license = licenses.asl20;
    maintainers = with maintainers; [ amaumene ];
  };
}
