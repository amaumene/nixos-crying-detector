{ pkgs, lib, setuptools, numpy, pillow, stdenv, buildPythonPackage, torch-rpi4 }:

buildPythonPackage rec {
  pname = "torchvision-rpi4";
  version = "0.11.0";

  format = "wheel";

  src = builtins.fetchurl {
    url = https://github.com/KumaTea/pytorch-aarch64/releases/download/v1.10.0/torchvision-0.11.0-cp39-cp39-manylinux_2_17_aarch64.manylinux2014_aarch64.whl;
    sha256 = "0zzymdfn3rks9ah53pfg5bw1lp6561byfl5axgf258wdckpw82j8";
  };

  propagatedBuildInputs = [ setuptools numpy pillow torch-rpi4];

  meta = with lib; {
    description = "torchvison";
    homepage = "url torchvision";
    license = licenses.asl20;
    maintainers = with maintainers; [ amaumene ];
  };
}
