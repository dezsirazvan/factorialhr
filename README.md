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
```

### Install dependencies

Using [Bundler](https://github.com/bundler/bundler) and [Yarn](https://github.com/yarnpkg/yarn):

```shell
bundle && yarn
```
### Initialize the database

```shell
rails db:create db:migrate db:seed
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
