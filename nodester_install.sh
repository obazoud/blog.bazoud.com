npm ls 2> /dev/null | grep "^├─" | sed 's/^├─┬ //g' | sed 's/^├── //g' | xargs nodester npm install $1
