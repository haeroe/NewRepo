#!/bin/bash
#author Haeroe

if [ $1 = --help ]; then
	echo "Example usage: newrepo.sh name reponame directory";
	exit 0;
fi

if [ $# != 3 ]; then
	echo "Bad arguments. Help: newrepo.sh --help";
	exit 0;
fi

USER=$1
NAME=$2
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
mkdir -p $3
pushd $3

echo "GitHub password for ${USER}:"
read -s PASS
curl -u "${USER}:${PASS}" https://api.github.com/user/repos -d "{\"name\":\"${NAME}\"}"

git init
git remote add origin git@github.com:${USER}/${NAME}.git

touch README
touch LICENSE
touch .gitignore

git add *
git commit -m "Initial commit"
git push origin master

popd
