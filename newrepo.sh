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

mkdir -p "$DIR" &> /dev/null
pushd "$DIR" &> /dev/null

echo "GitHub password for ${USER}:"
read -s PASS

curl -fsu "${USER}:${PASS}" https://api.github.com/user/repos -d "{\"name\":\"${NAME}\"}" > /dev/null || exit 1

if [ $# -eq 2 ]; then
	exit 0;
fi

git init > /dev/null
git remote add origin git@github.com:"${USER}"/"${NAME}".git > /dev/null

touch README
touch LICENSE
touch .gitignore

git add . > /dev/null
git commit -m "Initial commit" > /dev/null
git push -q origin master > /dev/null

popd
