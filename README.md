# 📚 NEDOQS Tutorials

This repository contains tutorials for the [School on Non-Equilibrium Dynamics of Open Quantum Systems](https://nedoqs2026.epfl.ch).

## 📡 Run online

Click the button below to open the tutorials in a new Codespace:

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://github.com/codespaces/new?hide_repo_select=true&ref=main&repo=1096466244&skip_quickstart=true&machine=standardLinux32gb&devcontainer_path=.devcontainer%2Fdevcontainer.json)

A machine type with at least 4 cores is highly recommended. This will consume more of your quota than a 2-core machine; see [📖 Free quota](https://docs.github.com/en/billing/concepts/product-billing/github-codespaces#free-quota) and [📖 Pricing](https://docs.github.com/en/billing/concepts/product-billing/github-codespaces#pricing) for more info.

If you prefer not to use GitHub/Codespaces, you can get a similar experience in [Renkulab](https://renkulab.io/p/ltpn/nedoqs-tutorials-2026), made and [hosted](https://renkulab.io/help/privacy) in 🇨🇭 (beta):

[![Open in Renkulab](https://tinyurl.com/open-in-renku)](https://renkulab.io/p/ltpn/nedoqs-tutorials-2026/sessions/01KF4EJVBB29DG052WEYQW9B9T/start)

## 💻 Run locally

While Codespaces are great for learning/experimenting, we advise to set up a local environment on your computer for more in-depth work and better performance.

If you are an advanced user, feel free to clone and setup your environment via the provided project files.

In order to ease the installation of all the dependencies, however, we also provide a *local* VS Code experience similar to GitHub Codespaces, via devcontainers.

The steps are generally as follows.
1. Install VS Code (MacOS users are advised to use [Homebrew](https://formulae.brew.sh/cask/visual-studio-code)).
2. Install Docker and the Dev Containers Extension according to the [documentation](https://code.visualstudio.com/docs/devcontainers/containers#_installation).
3. For a quickstart, click on the button below to clone the repo on your computer:  
   [![Open in Dev Containers](https://img.shields.io/badge/Clone_in_VS_Code-24292e.svg?labelColor=0065A9&style=for-the-badge&logo=data%3Aimage%2Fsvg%2Bxml%3Bbase64%2CPHN2ZyBpZD0iTGF5ZXJfMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB2aWV3Qm94PSIwIDAgMjM0IDIzNS4xIiB3aWR0aD0iMjQ4OCIgaGVpZ2h0PSIyNTAwIj48c3R5bGU%2BLnN0MHtmaWxsOiNmZmZmZmZ9PC9zdHlsZT48cGF0aCBjbGFzcz0ic3QwIiBkPSJNODMuMyAxNDMuOWwtNTggNDUuMkwwIDE3Ni41VjU4LjdMMjUuMiA0Nmw1Ny42IDQ1LjNMMTc0IDBsNjAgMjMuOXYxODYuOWwtNTkuNyAyNC4zLTkxLTkxLjJ6bTg4LjkgMTUuOVY3NS4zbC01NC42IDQyLjMgNTQuNiA0Mi4yek0yNy4zIDE0NC42TDU2IDExOC41IDI3LjMgODkuOXY1NC43eiIvPjwvc3ZnPgo%3D&logoColor=white)](https://vscode.dev/redirect?url=vscode://vscode.git/clone?url=https://github.com/ltpn/nedoqs-tutorials.git)  
   Once you've chosen a destination folder and you've opened the cloned repo, VS Code will prompt you to **Reopen in Container**; click that button and you're all set.  
   👉 Alternatively, you can manually clone the repo via `git clone https://github.com/ltpn/nedoqs-tutorials.git` (preferred) or download a [zipped copy](https://github.com/ltpn/nedoqs-tutorials/archive/refs/heads/main.zip) and unzip it (discouraged), choose `File -> Open Folder`, and select the folder with the repo. If VS Code does not prompt you to "Reopen in Container", you can also do this directly via the command palette ([📖 documentation](https://code.visualstudio.com/docs/devcontainers/containers#_quick-start-open-an-existing-folder-in-a-container)).

**Notes:**  
The similar command **Dev Containers: Clone Repository in Container Volume...** will clone the repo in an isolated volume instead of your computer. This means that any file modifications in the project folder will **not** be accessible from your computer unless you copy them over manually or set up a bind mount. For more info, refer to the [📖 documentation](https://code.visualstudio.com/docs/devcontainers/containers#_quick-start-open-a-git-repository-or-github-pr-in-an-isolated-container-volume).  
The container is also CUDA-ready (beta). If you have an NVIDIA GPU available, you can take advantage of GPU acceleration by installing the [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html) on Linux or using [NVIDIA GPU Paravirtualization](https://docs.docker.com/desktop/features/gpu/) via Docker Desktop on Windows.

## 💡 Tips

If you don't know how to use Git, learn it; it will be worth the effort. You can get started with [this](https://nbviewer.org/github/ICESAT-2HackWeek/intro-jupyter-git/blob/master/03-Git-Tutorial.ipynb) great interactive tutorial, and/or consult GitHub's [Git Guide](https://github.com/git-guides).
