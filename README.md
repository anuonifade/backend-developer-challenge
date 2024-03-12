# README

The documentation contains the requirement and how to setup the App to run locally.

## Application Setup

### Install Ruby and Ruby on Rails

* To install Ruby on any of the operating system, follow the information [here](https://www.ruby-lang.org/en/documentation/installation/). The ruby version used for the project is 3.1.1

* To install Ruby using RVM(Ruby Version Manager), follow the instructions [here](https://www.phusionpassenger.com/library/walkthroughs/deploy/ruby/ownserver/nginx/oss/install_language_runtime.html)

* Install bundler `gem install bundler`

* Install rails `gem install rails`.

### Setup the App

* Clone the app [here](https://github.com/anuonifade/backend-developer-challenge)

* cd into the app and run the following commands to generate the private/public key pair. This is needed to sign the JWT.

##### Private Key

```
openssl genrsa -out private_key.pem 2048
```

##### Public key

```
openssl rsa -pubout -in private_key.pem -out public_key.pem
```

* Run `bundle install` to install all app dependencies.
* Any gem that is not installing can be alternatively installed using `gem install GEM_NAME` e.g `gem install puma`

* Create a `.env` file in the root of the app and add the following. You can use your value.

```
PORT=
POSTGRES_USER=
POSTGRES_PASSWORD=
POSTGRES_DB=
RAILS_MAX_THREADS=
POSTGRES_PORT=5432
```

#### Database Setup

* Download and install Postgresql using the instructions [here](https://www.postgresql.org/download/)

* Install Postgresql using Homebrew [here](https://wiki.postgresql.org/wiki/Homebrew)

##### Create App Database

```ruby
rails db:create # Should the dev and test database
```

```ruby
rails db:migrate # To create the tables, columns and relationships
```

#### Run the App

```
rails server 
```

* The App should be accessible through the url `http://localhost:300/`

* You should see the message in the image below if everything runs well.


## How to run the test suite

The Application setup should have also set up all the dependencies for the test suite. Use the following command to run the test suite.

```ruby
rails test
```

## Running the App with Docker

* Ensure you have docker running on your local machine. Follow the instructions [here](https://docs.docker.com/engine/install/) to setup docker on your operating system of choice.

* To check if docker is running on your machine, run the following

```
docker info
```

* To install the app dependencies run the following docker command

##### For compose version 3 or later use

```
docker compose build 

docker compose up
```

##### For compose version 2 or earlier, use

```
docker-compose build

docker-compose up
```

* App should be accessible on `http://localhost:3000.
