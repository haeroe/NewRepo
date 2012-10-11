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

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
mkdir -p $3
cd $3

echo "GitHub password for $1:"
read -s PASS
curl -u "$1:$PASS" https://api.github.com/user/repos -d "{\"name\":\"$2\"}"

git init
git remote add origin git@github.com:$1/$2.git

touch README
touch LICENSE
touch .gitignore

git add *
git commit -m "Initial commit"
git push origin master

cd $DIR
