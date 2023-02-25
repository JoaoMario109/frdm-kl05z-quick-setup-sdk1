

<!--
    The README template used is othneildre/Best-README-Template
    All template credits are owned by the template creator
    Also check out the template page
    https://github.com/othneildrew/Best-README-Template
-->

<div id="top"></div>

<!-- PROJECT LOGO -->
<br />
<div align="center">
  <h3 align="center">FRDM-KL05Z SDK 1.x Setup</h3>

  <p align="center">
    Base project setup for the board FRDM-KL05Z using Visual Studio Code and Cmake with the SDK 1.x
    <br />
    <br />
    <a href="https://github.com/JoaoMario109/frdm-kl05z-quick-setup-sdk1/issues">Report Bug</a>
    ·
    <a href="https://github.com/JoaoMario109/frdm-kl05z-quick-setup-sdk1/issues">Request Feature</a>
  </p>
</div>


<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
  </ol>
</details>

<!-- ABOUT THE PROJECT -->
<div id="about-the-project"></div>

## About The Project

Base project project setup for the board FRDM-KL05Z using CMake for Visual studio code with the SDK 1.x

<!-- BUILT WITH -->
<div id="built-with"></div>

### Built With

* [CMake](https://cmake.org/)

<p align="right">(<a href="#top">back to top</a>)</p>

<hr />

<!-- GETTING STARTED -->
<div id="getting-started"></div>

## Getting Started

<!-- PREREQUISITES -->
<div id="prerequisites"></div>

### Prerequisites

* The project uses [CMake](https://cmake.org/) for its build, so make sure you have it installed and working properly on your machine.
* This base project was built with linux machine in mind but can easily be converted to be used in a windows or macOS machine

<!-- INSTALLATION -->
<div id="installation"></div>

### Installation

1. Make sure to have all dependencies of the toolchain installed (Obs theses packages names are used to install with pacman tool for Arch linux, search for the equivalent for your Operational system)
   1. arm-none-eabi-newlib
   2. arm-none-eabi-gcc
   3. arm-none-eabi-binutils
   4. arm-none-eabi-gdb
   5. jlink
   6. doxygen (Optional)

2. Install all needed Visual Studio Code extensions
   1. ms-vscode.cpptools
   2. marus25.cortex-debug
   3. ms-vscode.cmake-tools
   4. twxs.cmake
   5. dan-c-underwood.arm
   6. zixuanwang.linkerscript
   7. cschlosser.doxdocgen (Optional)

3. Clone the repository.
   ```sh
   git clone https://github.com/JoaoMario109/frdm-kl05z-quick-setup-sdk1.git
   ```

4. Configuring the project files and paths
   1. Configuring the arm-none-eabi-gcc.cmake file
      1. Search for the ARM_TOOLCHAIN_DIR variable and sets its value to be the path where the toolchain is installed in your machine
   2. Configuring the CMakeLists.txt file
      1. Search for the project() function and change the name (Eg: kl05z-sample-project -> my_project), description (Eg: kl05z-sample-project -> some nice description about my project) and the version (Eg: VERSION 1.0 -> Version 0.2)
   3. Configuring the documentation generation in the file docs/Doxyfile.in (Optional)
      1. Search for the properties PROJECT_NAME, PROJECT_NUMBER, PROJECT_BRIEF and change their values to match the values that you edited in your CMakeLists.txt
   4. Configuring the .vscode folder
      1. Edit the file c_cpp_properties.json and change the ***compilerPath*** property to match the location of your compiler
      2. Edit the file launch.json and change the property ***executable*** to match the path with the name of your executable file that you used in the CMakeLists.txt (Eg: \${workspaceRoot}/build/kl05z-sample-project.elf -> \${workspaceRoot}/build/my_project.elf)
      3. Edit the file launch.json and change the property ***serverpath*** to match you jlink server path location
      4. Edit the file launch.json and change the property ***armToolchainPath*** to match your arm toolchain path location
      5. Edit the file settings.json and change the property ***cortex-debug.armToolchainPath*** to match your arm toolchain path

<p align="right">(<a href="#top">back to top</a>)</p>

<hr />

<!-- USAGE -->
<div id="usage"></div>

## Usage

When all configurations are ready, you first must select some kit to be used in the CMake extension and build the project, to make this follow the steps bellow

1. Select a kit, search fot the button ***Select a kit*** in the left lower side of the vscode or use the command using the *ctrl+shift+p* / *F1* and after prompting the command ***Cmake: Select a Kit***, with all kits available select the ***GCC Arm Embedded***
2. Build the project using the ***Build*** button near the same location from the button on step 1 or use the command pallet *ctrl+shift+p* / *F1* and prompting the command ***Cmake: Build***
3. Make sure to plug your board on your computer
4. Now use the button in the left upper part of vscode *run -> Start Debugging* / *F5*

<p align="right">(<a href="#top">back to top</a>)</p>

<hr />

<!-- CONTRIBUTING -->
<div id="contributing"></div>

## Contributing

All contributions are welcome to the project.

<p>
When contributing to the project, make sure to ident your code using tabs with size 4, also make sure to take a better look in the conventions used in the code and try to follow it, this helps keep the code uniform, easy to understand.
</p>

Also remember the branch structures of the project
* ***master*** -> This branch only contains releases that are approved to deployment
* ***develop*** -> This branch only contains complete implemented and working features, all code submitted to these branch should compile without any compiler error.
* ***{developer-short-name}/{feature-description}*** -> Any code in development or feature improvement.

1. Get the last develop and use as base for your branch
2. Create your branch (`git checkout -b {developer-short-name}/{feature-description}`)
3. Make your changes to the code
4. Add only needed changes to staged
5. Commit your changes with good titled and description messages (`git commit`)
6. Push to the branch (`git push origin {developer-short-name}/{feature-description}`)
7. Open a PullRequest to develop
8. Await reveal and approval to rebase and merge

<p align="right">(<a href="#top">back to top</a>)</p>

<hr />

<!-- LICENSE -->
<div id="license"></div>

## License

Distributed under the MIT License. See `LICENSE.txt` for more information.

<p align="right">(<a href="#top">back to top</a>)</p>

<hr />

<!-- CONTACT -->
<div id="contact"></div>

## Contact

João Mário Carnieletto Izoton Lago - [Joao Mario](https://www.linkedin.com/in/jo%C3%A3o-m%C3%A1rio-lago-a69b2b215/)

Project Link: [https://github.com/JoaoMario109/frdm-kl05z-quick-setup-sdk1](https://github.com/JoaoMario109/frdm-kl05z-quick-setup-sdk1)

<p align="right">(<a href="#top">back to top</a>)</p>