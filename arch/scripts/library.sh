#!/bin/bash

_isInstalledPacman() {
  package="$1"
  check="$(sudo pacman -Qs --color always "${package}" | grep "local" | grep "${package} ")"

  if [ -n "${check}" ]; then
    echo 0
    return
  fi

  echo 1
  return
}

_isInstalledYay() {
  package="$1"
  check="$(yay -Qs --color always "${package}" | grep "local" | grep "${package} ")"

  if [ -n "${check}" ]; then
    echo 0
    return
  fi

  echo 1
  return
}

_isInstalledFlatpak() {
  package="$1"
  check="$(flatpak list | grep "${package}")"

  if [ -n "${check}" ]; then
    echo 0
    return
  fi

  echo 1
  return
}

_installPackagesPacman() {
  toInstall=()

  for pkg; do
    if [[ $(_isInstalledPacman "${pkg}") == 0 ]]; then
      echo "${pkg} is already installed."
      continue
    fi

    toInstall+=("${pkg}")
  done

  if [[ "${toInstall[@]}" == "" ]]; then
    echo "👌 All pacman packages are already installed.";
    return
  fi

  echo -e "\nPackages not installed: ${toInstall[@]}\n"
  sudo pacman --noconfirm -S "${toInstall[@]}"
}

_installPackagesYay() {
  toInstall=()

  for pkg; do
    if [[ $(_isInstalledYay "${pkg}") == 0 ]]; then
      echo "${pkg} is already installed."
      continue
    fi

    toInstall+=("${pkg}")
  done

  if [[ "${toInstall[@]}" == "" ]]; then
    echo "👌 All aur packages are already installed.";
    return
  fi

  echo -e "\nAUR packages not installed: ${toInstall[@]}\n"
  yay --noconfirm -S "${toInstall[@]}"
}

_installPackagesFlatpak() {
  toInstall=()

  echo $pkg

  for pkg; do
    if [[ $(_isInstalledFlatpak "${pkg}") == 0 ]]; then
      echo "${pkg} is already installed."
      continue
    fi

    toInstall+=("${pkg}")
  done

  if [[ "${toInstall[@]}" == "" ]]; then
    echo "👌 All flatpak packages are already installed.";
    return
  fi

  echo -e "\nFlatpak packages not installed: ${toInstall[@]}\n"
  flatpak install "${toInstall[@]}"
}

_installSymLink() {
  name="$1"
  symlink="$2"
  linksource="$3"
  linktarget="$4"

  if [ -L "${symlink}" ]; then
    rm ${symlink}
    ln -s ${linksource} ${linktarget}

    echo "👍 Symlink ${linksource} -> ${linktarget} created."
    echo ""
  else
    if [ -d ${symlink} ]; then
      rm -rf ${symlink}/
      ln -s ${linksource} ${linktarget}

      echo "👍 Symlink for directory ${linksource} -> ${linktarget} created."
      echo ""
    else
      if [ -f ${symlink} ]; then
        rm ${symlink}
        ln -s ${linksource} ${linktarget}

        echo "👍 Symlink to file ${linksource} -> ${linktarget} created."
        echo ""
      else
        ln -s ${linksource} ${linktarget}

        echo "👍 New symlink ${linksource} -> ${linktarget} created."
        echo ""
      fi
    fi
  fi
}
