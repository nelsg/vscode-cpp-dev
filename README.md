# VSCode C/C++ project template

Project template for VSCode C/C++ development with Remotes (WSL/SSH), CMake, ccls, and CUDA.

- [VSCode C/C++ project template](#vscode-cc-project-template)
  - [Target](#target)
  - [Packages](#packages)
    - [VSCode extensions](#vscode-extensions)
  - [Sample Project](#sample-project)
  - [Settings](#settings)
    - [Build commands](#build-commands)
    - [C/C++ extension](#cc-extension)
    - [ccls extension](#ccls-extension)
    - [Debug](#debug)

## Target

*   [Visual Studio Code](https://code.visualstudio.com)
*   WSL or [Remote SSH/WSL](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack)

## Packages

The following packages are assumed to be already installed on **Linux/WSL**. 

Compilers:

*   [Clang](https://clang.llvm.org)
*   [CMake](https://cmake.org) (ver 3.13 or above)
*   Make or [Ninja](https://github.com/ninja-build/ninja)

Libraries:

*   [Google Test](https://github.com/google/googletest)
*   [Boost](https://www.boost.org)

Options:

*   [ccls](https://github.com/MaskRay/ccls) (C/C++/ObjC language server)
    *   for MacOS/Linux(WSL): `brew install ccls`
    *   for Windows: build by yourself ([the guide](https://cxuesong.com/archives/1067))
*   [vcpkg](https://github.com/microsoft/vcpkg) (C/C++ package manager)
*   [clang-tidy](https://clang.llvm.org/extra/clang-tidy/)
*   CUDA (Linux)

### VSCode extensions

*   [C/C++](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools)
*   [Remote Development](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack)

Options:

*   [ccls](https://marketplace.visualstudio.com/items?itemName=ccls-project.ccls)


## Sample Project

This repository contains a CMake project for sample. The sample project is consisting of

*   `header_lib_sample`: example of header only library using [Boost](https://www.boost.org)
*   `static_lib_sample`: example of static library using [Boost](https://www.boost.org)
*   `src`: main project linking aboves
*   `cuda_sample`: example of CUDA project (disabled default)
*   `test`: Test projects using [Google Test](https://github.com/google/googletest) for libraries

## Settings

### Build commands

The prepared tasks run [CMake](https://cmake.org) and the build system.

*   `CMake clean`: cleanup `./build` directory
*   `CMake clang++ Debug`: run CMake and build with [clang++](https://clang.llvm.org), [clang-tidy](https://clang.llvm.org/extra/clang-tidy/) and `Debug`
*   `CMake clang++ Release`: run CMake and build with [clang++](https://clang.llvm.org) and `Release`
*   `CMake gcc Debug`: run CMake and build with [gcc](https://gcc.gnu.org) and `Debug`
*   `CTest`: run ctest

Edit `args` key in `.vscode/tasks.json` if you want to customize options.

```json
            "args": [
                "-DCMAKE_TOOLCHAIN_FILE=$(cat",
                "~/.vcpkg/vcpkg.path.txt)/scripts/buildsystems/vcpkg.cmake",
                "-DCMAKE_CXX_COMPILER=clang++",
                "-UCLANG_TIDY",
                "-DCLANG_TIDY=ON",
                "-G",
                "Ninja",
                "-DCMAKE_BUILD_TYPE=Debug",
                "..",
                "&&",
                "ninja",
                "|",
                "perl",
                "../scripts/ninja_filter.pl"
            ],
```

Use [vcpkg](https://github.com/microsoft/vcpkg) as CMake tool chain here,

```json
                "-DCMAKE_TOOLCHAIN_FILE=$(cat",
                "~/.vcpkg/vcpkg.path.txt)/scripts/buildsystems/vcpkg.cmake",
```

Use [clang++](https://clang.llvm.org) as C++ compiler,

```json
                "-DCMAKE_CXX_COMPILER=clang++",
```

Enable running [clang-tidy](https://clang.llvm.org/extra/clang-tidy/), (you need to put `.clang-tidy` file on root),

```json
                "-UCLANG_TIDY",
                "-DCLANG_TIDY=ON",
```

Use `Ninja` as build system and build automatically,

```json
                "-G",
                "Ninja",
                "&&",
                "ninja",
```

If you want to generate 'Makefile', you simply remove '-G' options and pass to `make`.

The last pipe is a little trick,

```json
                "|",
                "perl",
                "../scripts/ninja_filter.pl"
```

This script has two roles.

*   convert absolute (Linux) file path to the relative path which can be interpreted also on Windows
*   cache the output and print out the same previous build

When the source codes are not changed, a build tool may not output anything. For this case, the problem tab on VSCode should keep the same outputs because it will be refreshed when a new task is executed.

### [C/C++](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools) extension

If you use external headers, you need to add the path in `c_cpp_properties.json`

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

The above example adds the path to installed packages in [vcpkg](https://github.com/microsoft/vcpkg) to `includePath` key. Note that `includePath` accepts both Windows and Linux paths for WSL environment.

### [ccls](https://marketplace.visualstudio.com/items?itemName=ccls-project.ccls) extension

[ccls](https://github.com/MaskRay/ccls) is a lightweight language server for C/C++, ObjC (and CUDA partially). [ccls](https://marketplace.visualstudio.com/items?itemName=ccls-project.ccls) is faster and smarter than [C/C++](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools) intellisense.

However, `ccls` extension does not provide the debugging function. The following settings are applied to disable [C/C++](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools) extensions intellisense to avoid overlaps of such features in `ccls`.

```json
    "C_Cpp.autocomplete": "Disabled",
    "C_Cpp.errorSquiggles": "Disabled",
    "C_Cpp.formatting": "Disabled",
    "C_Cpp.intelliSenseEngine": "Disabled",
```

Semantic highlighting is also enabled here,

```json
    "ccls.highlighting.enabled.enumConstants": true,
    "ccls.highlighting.enabled.enums": true,
    "ccls.highlighting.enabled.freeStandingFunctions": true,
    "ccls.highlighting.enabled.freeStandingVariables": true,
    "ccls.highlighting.enabled.globalVariables": true,
    "ccls.highlighting.enabled.macros": true,
    "ccls.highlighting.enabled.memberFunctions": true,
    "ccls.highlighting.enabled.memberVariables": true,
    "ccls.highlighting.enabled.namespaces": true,
    "ccls.highlighting.enabled.parameters": true,
    "ccls.highlighting.enabled.staticMemberFunctions": true,
    "ccls.highlighting.enabled.staticMemberVariables": true,
    "ccls.highlighting.enabled.templateParameters": true,
    "ccls.highlighting.enabled.typeAliases": true,
    "ccls.highlighting.enabled.types": true,
```

Working with [CMake](https://cmake.org), `ccls.misc.compilationDatabaseDirectory` specifies a directory where `compile_commands.json` is output.

```json
    "ccls.misc.compilationDatabaseCommand": "scripts/compile_commands_filter.py",
```

 Additionally for CUDA project, `scripts/compile_commands_filter.py` converts `nvcc` commands and options to those of `clang++` options.

```json
    "ccls.misc.compilationDatabaseDirectory": "build",
    "files.associations": {
        "*.cu": "cpp"
    }
```

For `ccls` on windows, the current settings cannot analyze WSL paths written in `compile_commands.json`. You may have to put `.ccls` (see [ccls wiki](https://github.com/MaskRay/ccls/wiki/Project-Setup#ccls-file)).

### Debug

In `launch.json`, put the program path to `program` key,

```json
            "program": "./build/Debug/bin/cmake_sample_main",
```
