# CkPrzelewy24
 
Rails engine to handle basic Przelewy24 payment gateway


## Installation
Add this line to your application's Gemfile:

```ruby
gem 'ck_przelewy24', git: 'https://YourAccessTokenHere:x-oauth-basic@github.com/ck-cyberkom/ck-przelewy24.git'
```

and run

```ruby
bundle install
rails ck_przelewy24:install:migrations
rake db:migrate
```

mount engine routes in your `config/routes.rb`

```
mount CkPrzelewy24::Engine => "/ck_przelewy24", as: "ck_przelewy24"
```

create initializer `config/initializers/ck_przelewy24.rb` with follow settings:

```ruby
CkPrzelewy24.order_class = Order model name
CkPrzelewy24.przelewy24_url = Przelewy24 url
CkPrzelewy24.przelewy24_crc = Przelewy24 crc
CkPrzelewy24.przelewy24_merchant_id = Przelewy24 merchant_id
CkPrzelewy24.site_url = Your site url
#  Settings below are optional:
- Service to call after payment confirmation, it must take order_id as a param.
CkPrzelewy24.service_name_call_after_confirmation
```


## Usage

In your order logic controller to register and get przelewy24 url,
use method `CkPrzelewy24.p24_request_path(transaction_params)`
with params:
```
{
    order_price: Order price in float,
    transaction_description: Transaction description,
    order_email: Email,
    url_return: Return url,
    client_name: Client name,
    client_phone: Phone,
    order: Your saved to DB Order Object
}
```
