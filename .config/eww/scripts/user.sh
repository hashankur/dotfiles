#!/bin/sh

name () {
  username=$(whoami)
  echo ${username^}
}

name
