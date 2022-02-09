{ lib, buildPythonPackage, fetchPypi,
  numpy,
  pooch,
  scikit-learn,
  decorator,
  audioread,
  numba,
  soundfile,
  resampy,
  matplotlib
}:

buildPythonPackage rec {
  pname = "librosa";
  version = "0.9.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "1zchsf6al4877gqy21vqsfz4b09n1qv2nhxing8zhn4q7dfnf8fd";
  };

  buildInputs = [ matplotlib ];

  propagatedBuildInputs = [
    numpy
    pooch
    scikit-learn
    decorator
    audioread
    numba
    soundfile
    resampy
  ];

  meta = with lib; {
    homepage = "http://www.librosa.org/";
    description = "audio and music processing in Python";
    license = licenses.bsd3;
    maintainers = with maintainers; [ amaumene ];
  };
}
