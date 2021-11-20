#!/usr/bin/env bash

curl -sSL https://rvm.io/mpapis.asc | gpg --import -
curl -sSL https://rvm.io/mpapis.asc | sudo gpg2 --import -
curl -sSL https://rvm.io/pkuczynski.asc | sudo gpg2 --import -
curl -L get.rvm.io | bash -s stable
source /etc/profile.d/rvm.sh

rvm reload
rvm requirements run
rvm install 2.2.4
rvm use 2.2.4 --default

gem install redis -v 3.3.3
