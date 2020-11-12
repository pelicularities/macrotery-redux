#!/usr/bin/zsh
echo "Scraping files from bestrandom..."
for i in {1..50}; do
  echo "Scrape $i..."
  curl 'https://www.bestrandoms.com/random-address-in-sg?quantity=20' > "address${i}.html"
done
