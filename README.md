# FactorialHR

[https://github.com/dezsirazvan/factorialhr](https://github.com/dezsirazvan/factorialhr)

## Install

### Clone the repository

```shell
git clone git@github.com:dezsirazvan/factorialhr.git
cd factorialhr
```

### Check your Ruby version

```shell
ruby -v
```

The ouput should start with something like `ruby 2.5.8`

If not, install the right ruby version using [rbenv](https://github.com/rbenv/rbenv) (it could take a while):

```shell
rbenv install 2.5.8
rbenv local 2.5.8
```

### Install dependencies

Using [Bundler](https://github.com/bundler/bundler) and [Yarn](https://github.com/yarnpkg/yarn):
```shell
Last versions:

gem install bundler
brew install yarn

Project Versions:

gem install bundler:2.2.11
brew install yarn@1.22.5
```
```shell
bundle && yarn
```
### Install postgresql

```shell
brew install postgresql

postgres --version
postgres (PostgreSQL) 13.3

brew services start postgresql
```
### Initialize the database

```shell
rails db:create db:migrate
```
## Serve Rails Server

```shell
rails s
```
## Serve Webpacker Dev Server

```shell
./bin/webpack-dev-server 
```
## Api Documentation

[http://localhost:3000/apipie](http://0.0.0.0:3000/apipie/)
## Generate examples for documentation

```shell
APIPIE_RECORD=examples bundle exec rspec
```
