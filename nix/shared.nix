# nix/shared.nix
#
# This file provides functions used by ObjectDiff's Nix flake.
#
# Copyright (C) 2025-today rydnr's object-diff
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
rec {
  shellHook-for = { nixpkgs-release, org, package, repo, tag }:
    ''
      export PS1="\033[37m[\[\033[01;34m\]${org}/${repo}\033[01;37m|\033[01;33m${tag}[\033[00m\] "
      echo -e "\033[36m ▗▄▖ ▗▖      ▗▖▗▞▀▚▖▗▞▀▘   ■  \033[31m▗▄▄▄  ▄ ▗▞▀▀▘▗▞▀▀▘\033[32mhttps://github.com/${org}\033[0m"
      echo -e "\033[36m▐▌ ▐▌▐▌      ▗▖▐▛▀▀▘▝▚▄▖▗▄▟▙▄▖\033[31m▐▌  █ ▄ ▐▌   ▐▌   \033[33mhttps://github.com/${org}/${repo}:${tag}\033[0m"
      echo -e "\033[36m▐▌ ▐▌▐▛▀▚▖▄  ▐▌▝▚▄▄▖      ▐▌  \033[31m▐▌  █ █ ▐▛▀▘ ▐▛▀▘ \033[34mhttps://pharo.org\033[0m"
      echo -e "\033[36m▝▚▄▞▘▐▙▄▞▘▀▄▄▞▘           ▐▌  \033[31m▐▙▄▄▀ █ ▐▌   ▐▌   \033[35mhttps://github.com/nixos/nixpkgs/tree/${nixpkgs-release}\033[0m"
      echo -e "\033[36m                          ▐▌\033[0m"
      echo
      echo -e "Thank you for using \033[32m${package.pname}\033[0m \033[33m${package.version}\033[0m \033[31m(${org}/${repo}-${tag})\033[0m and for your appreciation of free software."
    '';
  devShell-for = { nixpkgs-release, org, package, pkgs, repo, tag}:
    pkgs.mkShell {
      shellHook = shellHook-for {
          inherit nixpkgs-release org package repo tag;
      };
    };
  app-for = { package, entrypoint }: {
    type = "app";
    program = "${package}/bin/${entrypoint}.sh";
  };
}
