# CMake C++/CUDA template for Visual Studio Code

This CMake C++ template includes projects:

*   C++ header only library: `header_lib_sample`.
*   C++ static library: `static_lib_sample`.
*   Executable: `src`.
*   Unit tests with [Google Test](https://github.com/google/googletest): `test`.
*   (option) CUDA executable: `cuda_sample`.

The pre-configured VSCode settings with extensions enable a modern development environment with C++17:

*   Intellisense and clang-format with [ccls](https://github.com/MaskRay/ccls).
*   Package manager with [vcpkg](https://github.com/microsoft/vcpkg).
*   Linter with [Clang-Tidy](https://clang.llvm.org/extra/clang-tidy/).
*   Code debugging with [C/C++](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools).
*   GUI-selectable CMake settings with [CMake Tools](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cmake-tools).
*   Sanitizer supports with [sanitizers-cmake](https://github.com/arsenm/sanitizers-cmake).

## Usage

### Prerequisites

*   Visual Studio Code
*   Linux/WSL
*   [option] CUDA

### Install [brew](https://docs.brew.sh/Homebrew-on-Linux) and packages

Install brew on Linux.

```bash
$ sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
```

Add Homebew to your `PATH`.

`~/.profile`

```bash
eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
```

See [the documentation](https://docs.brew.sh/Homebrew-on-Linux) in details.

Install packages.

```bash
$ brew install ccls cmake ninja
```

**Important!** Unlink gcc on brew.

```bash
$ brew unlink gcc
```

### Install [vcpkg](https://github.com/microsoft/vcpkg) and packages

Before install packages with using vcpkg, set your compilers for safety for example:

```bash
$ export CC=/home/linuxbrew/.linuxbrew/bin/clang
$ export CXX=/home/linuxbrew/.linuxbrew/bin/clang++
```

Clone vcpkg.

```bash
$ git clone https://github.com/Microsoft/vcpkg.git
```

Install vcpkg.

```bash
$ cd vcpkg
$ ./bootstrap-vcpkg.sh
$ ./vcpkg integrate install
```

Install packages.

```bash
$ ./vcpkg install boost gtest
```

### Install VSCode extensions

Install extensions in your VSCode. On Windows 10, you need to install followings with [Remote-WSL](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-wsl) connected.

*   [CMake Tools](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cmake-tools)
*   [ccls](https://marketplace.visualstudio.com/items?itemName=ccls-project.ccls)
*   [C/C++](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools)
*   (option) [vscode-clangd](https://marketplace.visualstudio.com/items?itemName=llvm-vs-code-extensions.vscode-clangd)
    *   Clang-tidy checks will be enabled for opened file.

### Install other packages

To generate `compile_commands.json` with header files, install [compdb](https://github.com/Sarcasm/compdb)

```bash
$ pip3 install compdb
```

### Configure the project

1.  Clone this repository with `--recursive` to include submodule.
2.  Open the project in VSCode.
3.  Replace keyword `PATH_TO_VCPKG` by **your vcpkg path** in `.vscode`. Press `Ctrl + Shift + F` to open search view and replace. The files `.vscode/c_cpp_properties.json` and `.vscode/cmake-kits.json` will be found.
4.  Add `ccls.clang.resourceDir` with **your LLVM directory** to `settings.json` e.g.
    ```json
    {
        "ccls.clang.resourceDir": "/home/linuxbrew/.linuxbrew/Cellar/llvm/9.0.0_1/lib/clang/9.0.0/"
        // The version number depends                                     ~~~~~~~           ~~~~~
    }
    ```
5.  If you want to change the compilers from clang to gcc/g++, edit `.vscode/cmake-kits.json`.
6.  If you want to compile CUDA project, uncomment `# add_subdirectory(cuda_sample)` in `CMakeLists.txt`

### Build the project

*   Select CMake configure on VSCode status bar: e.g. `Debug No Clang-Tidy No AMTsan No UBsan`
*   Select CMake kits on VSCode status bar: e.g. `clang++`
*   Press `F7` to configure and build the project.
*   Press `F1` and run `ccls: Restart language server` to load `compile_commands.json` and ccls will restart.
*   Press `F5` to debug the target executable.
