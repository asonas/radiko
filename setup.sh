mkdir log
mkdir -p public/mp3
bundle install
docker pull yyoshiki41/radigo
echo "execute: whenever --update-crontab"
