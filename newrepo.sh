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
