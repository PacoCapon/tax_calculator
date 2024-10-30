# README

## Description:

Implementation of a system that is capable of calculating taxes on the sales of products and services.
You can start the server and CRUD over Products and Buyers, you can also calculate the taxes with the tax calculator that will create a register in the transaction table with the provided data.

## Versions:

- Ruby: 3.3.4
- Rails: 7.2.2.1

## Gems used

* rspec-rails (https://github.com/rspec/rspec-rails) - Used for tests purposes
* faker (https://github.com/faker-ruby) - Used to create fake data for tests
* factory-bot-rails (https://github.com/thoughtbot/factory_bot_rails) - Used to create fake data for tests
* byebug (https://github.com/deivid-rodriguez/byebug) - Used for debuggin purposes
* country_select (https://github.com/countries/country_select) - Used for country select
* bootstrap (https://rubygems.org/gems/bootstrap/versions/5.2.3) - Used for styling the views

### Installation

To install all gems:

``` bundle install ```

After that you have to run the migrations:

``` rails db:migrate ```

### Start server

To start the server that will execute everyday at 8:00 UTC the task to create the disbursement:

``` rails s ```

### Fill the database with some mock data

There is some information to test the implementation in the seeds file. To fill the development database with this data you have to use this:

``` rails db:seed ```

This will create some products, buyers and transactions.

### Run tests

``` bundle exec rspec ```


