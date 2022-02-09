{ lib, buildPythonPackage, fetchFromGitHub,
  fastai,
  pyaudio,
  librosa,
  python-pushover
}:

buildPythonPackage rec {
  pname = "colin-crying-detector";
  version = "0.0.1";

  src = fetchFromGitHub {
    owner = "amaumene";
    repo = "colin-crying-detector";
    rev = "main";
    sha256 = "15l53gr2fd37q3mwy4wvl08w8psqn54csrwrh87nbnlswc0sxjbr";
  };

  propagatedBuildInputs = [
    fastai
    pyaudio
    librosa
    python-pushover
  ];

  meta = with lib; {
    homepage = "http://colin.maumene.org/";
    description = "Crying detector for babies";
    license = licenses.bsd3;
    maintainers = with maintainers; [ amaumene ];
  };
}
