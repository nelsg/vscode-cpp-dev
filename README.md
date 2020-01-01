# VSCode C/C++ project template

Project template for VSCode C/C++ development with Remotes (WSL/SSH), CMake, language server and CUDA.

- [VSCode C/C++ project template](#vscode-cc-project-template)
  - [Target](#target)
  - [Packages](#packages)
    - [VSCode extensions](#vscode-extensions)
  - [Sample Project](#sample-project)
  - [VSCode settings](#vscode-settings)
    - [C/C++](#cc)
    - [ccls](#ccls)
    - [clangd](#clangd)
    - [CMake Tools](#cmake-tools)

## Target

*   [Visual Studio Code](https://code.visualstudio.com)
*   [Remote SSH or WSL](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack)

## Packages

The following packages are assumed to be already installed on **Linux/WSL**. 

Compilers:

*   [Clang](https://clang.llvm.org)
*   [CMake](https://cmake.org) (ver 3.13 or above)

Libraries:

*   [Google Test](https://github.com/google/googletest)
*   [Boost](https://www.boost.org)

Options:

*   [ccls](https://github.com/MaskRay/ccls) (C/C++ language server)
    *   for MacOS/Linux(WSL): `brew install ccls`
    *   for Windows: build by yourself ([the guide](https://cxuesong.com/archives/1067))
*   [clangd](https://clang.llvm.org/extra/clangd/) (C/C++ language server)
*   [compdb](https://github.com/Sarcasm/compdb) (compilation database generator)
    *   `pip install compdb`
*   [vcpkg](https://github.com/microsoft/vcpkg) (C/C++ package manager)
*   [clang-tidy](https://clang.llvm.org/extra/clang-tidy/)
*   CUDA (Linux)

### VSCode extensions

*   [C/C++](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools)
*   [Remote Development](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack)
*   [CMake Tools](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cmake-tools)

Options:

*   [ccls](https://marketplace.visualstudio.com/items?itemName=ccls-project.ccls)
*   [vscode-clangd](https://marketplace.visualstudio.com/items?itemName=llvm-vs-code-extensions.vscode-clangd)


## Sample Project

This repository contains a CMake project for the sample. The sample project is consisting of

*   `header_lib_sample`: example of a header-only library using [Boost](https://www.boost.org)
*   `static_lib_sample`: example of a static library using [Boost](https://www.boost.org)
*   `src`: main project linking above libraries
*   `cuda_sample`: example of CUDA project (disabled default)
*   `test`: Test projects using [Google Test](https://github.com/google/googletest) for libraries

## VSCode settings

### [C/C++](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools)

If you use external headers, you need to add the include path in `c_cpp_properties.json`.

```json
{
    "configurations": [
        {
            "name": "WSL",
            "intelliSenseMode": "clang-x64",
            "compilerPath": "/usr/bin/clang++",
            "includePath": [
                "${workspaceRoot}/**",
                "/path/to/vcpkg/installed/x64-linux/include"
            ],
            "defines": [],
            "browse": {
                "path": [
                    "${workspaceFolder}"
                ],
                "limitSymbolsToIncludedHeaders": true,
                "databaseFilename": "${workspaceFolder}/.vscode/browse.vc.db"
            },
            "cStandard": "c11",
            "cppStandard": "c++17"
        }
    ],
    "version": 4
}
```

The above example adds the path to installed packages in [vcpkg](https://github.com/microsoft/vcpkg) to `includePath` key.

### [ccls](https://marketplace.visualstudio.com/items?itemName=ccls-project.ccls)

You may have to set the patn to Clang resource directory `ccls.clang.resourceDir` in `settings.json`, e.g.
```json
{
    "ccls.clang.resourceDir": "/home/linuxbrew/.linuxbrew/Cellar/llvm/9.0.0_1/lib/clang/9.0.0/"
}
```
See https://github.com/MaskRay/ccls/wiki/Install#clang-resource-directory.

### [clangd](https://marketplace.visualstudio.com/items?itemName=llvm-vs-code-extensions.vscode-clangd)

If you prefer clangd to ccls, remove to enable semantic highlighting settings here,
```json
{
    "clangd.semanticHighlighting": false
}
```

### [CMake Tools](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cmake-tools)

The custom toolchain using clang++ is added to `cmake-kits.json`. Set the path to toolchain file if you need,

```json
[
    {
        "name": "clang++",
        "toolchainFile": "/path/to/vcpkg/scripts/buildsystems/vcpkg.cmake",
        "compilers": {
            "C": "clang",
            "CXX": "clang++"
        }
    }
]
```
