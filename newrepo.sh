#!/bin/bash
#author Haeroe

if [ $1 = --help ]; then
	echo "Example usage: newrepo.sh name reponame directory";
	exit 1;
fi

if [[ $# -lt 2 || $# -gt 3 ]]; then
	echo "Bad arguments. Help: newrepo.sh --help";
	exit 1;
fi

USER="$1"
NAME="$2"

if [ $# -eq 2 ]; then
	DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";
fi

if [ $# -eq 3 ]; then
	DIR="$3";
fi

mkdir -p "$DIR"
pushd "$DIR"


echo "GitHub password for ${USER}:"
read -s PASS

curl -fsu "${USER}:${PASS}" https://api.github.com/user/repos -d "{\"name\":\"${NAME}\"}" || exit 1

if [ $# -eq 2 ]; then
	exit 0;
fi

git init
git remote add origin git@github.com:"${USER}"/"${NAME}".git

touch README
touch LICENSE
touch .gitignore

git add .
git commit -m "Initial commit"
git push origin master

popd
