
# Introduction

An experimental CI/CD implementation for PyTorch Windows ARM64.

# Dependencies

- Windows ARM64

- [APL 24.04 for Windows](https://developer.arm.com/Tools%20and%20Software/Arm%20Performance%20Libraries#Software-Download)

- [sccache](https://github.com/mozilla/sccache/releases)

- [MSVC Build Tools](https://visualstudio.microsoft.com/downloads/#build-tools-for-visual-studio-2022) or Visual Studio 2022

    - **C/C++ Component** should be installed
    - **ARM64/ARM64EC** **individual** component should be installed

# Local Build

Set following variables in command line.

```
set PYTORCH_SOURCES_DIR="PYTORCH_SOURCE_DIR"
set DEPENDENCY_SCCACHE_DIR="DEPENDENCY_SCCACHE_DIR"
```

Depending on the BLAS option you choose, set relevant variables. Right now, APL and OpenBLAS are supported.

```
set ENABLE_APL=1
set DEPENDENCY_APL_DIR="APL_DIR"
```
or
```
set ENABLE_OPENBLAS=1
set DEPENDENCY_OPENBLAS_DIR="OPENBLAS_SOURCE_DIR"
```


Then call `build_local.bat` or `build_local.bat bootstrap` to clean build.

# CD - Release Workflow

Visit [Actions - Release](https://github.com/Windows-on-ARM-Experiments/pytorch-ci/actions/workflows/release.yml) page.

Click `Run workflow` and fill inputs.

- `PyTorch Repository`: Name of fork

- `PyTorch Branch`: Name of fork's branch

- `Release Wheel Name`: Preferred name for generated release.

It will generate wheel file under [Releases](https://github.com/Windows-on-ARM-Experiments/pytorch-ci/releases) page.

# CI - Build and Run Tests Workflow

Visit [Actions - Build and Run Tests](https://github.com/Windows-on-ARM-Experiments/pytorch-ci/actions/workflows/unit-tests.yml) page.

Click `Run workflow` and fill inputs.

- `PyTorch Repository`: Name of fork

- `PyTorch Branch`: Name of fork's branch

- `Enable PyTorch Build?`: If it should run PyTorch build

- `Enable PyTorch Clean?`: If it should run PyTorch clean 

    - This action will cause to lose build cache!

- `Enable PyTorch archive build output?`: If it should generate artifact from PyTorch build output.

- `Enable PyTorch tests run?`: If it should run tests