{
  runCommandNoCC,

  nix,
  nix-super,
  lix,
}:
runCommandNoCC "build-nix-benchmarks-0.1" {
  pname = "nix-benchmarks";
  version = "0.1";

  src = ../../src;

  env = {
    nix = "${nix}";
    nix_super = "${nix-super}";
    lix = "${lix}";
  };

  meta.mainProgram = "benchmark";
} ''
  substituteAll $src/benchmark.sh benchmark
  install -Dm755 -t $out/bin benchmark
''
