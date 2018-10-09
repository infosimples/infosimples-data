# Infosimples::Data

Ruby API for Infosimples::Data (https://infosimples.com/).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'infosimples-data'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install infosimples-data

## Usage

1. **Create a client**

  ```ruby
  require 'infosimples/data'
  client = Infosimples::Data::Client.new('my_token')
  ```

2. **Automate a service**

  ```ruby
  response = client.automate('correios/cep', cep: '01311915')
  response['code']                  # 200
  response['code_message']          # "A consulta foi realizada com sucesso e retornou um resultado."
  response['data']                  # Information about the postal code
  response['receipt']['sites_urls'] # Links for the original HTMLs.

  client.download_sites_urls(response) # Array with HTML bodies for `sites_urls`.
  ```

  > Check the full response in our documentation:
  > https://data.infosimples.com/docs

3. **Billing**

  ```ruby
  billing = client.billing          # Array of Hashes with:
  billing.first['name']             # - Name of the Token
  billing.first['quantity']         # - Number of automation requests the token has made
  billing.first['credits']          # - How many credits the token has used
  ```

4. **Pricing**

  ```ruby
  pricing = client.pricing          # Array of Hashes with:
  pricing.first['service']          # - Name of the service that can be automated
  pricing.first['credits']          # - How many credits this service uses
  ```

5. **Response codes**

  ```ruby
  # Check a response code:
  response['code'] == Infosimples::Data::CODE[:single_result]

  # List of codes
  {
    # success
    single_result:          200,
    multiple_results:       201,

    # error
    unexpected_error:       600,
    unauthorized:           601,
    invalid_service:        602,
    forbidden:              603,
    invalid_request:        604,
    timeout:                605,
    empty_parameters:       606,
    invalid_parameters:     607,
    refused_parameters:     608,
    attempts_exceeded:      609,
    failed_captcha:         610,
    incomplete_data:        611,
    inexistent:             612,
    blocked_request:        613,
    try_again:              614,
    source_unavailable:     615,
    source_error:           616,
    service_overloaded:     617,
    rate_limit_exceeded:    618,
    converted_parameters:   619,
    permanent_error:        620,
    receipt_error:          621,
  }
  ```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/infosimples/infosimples-data.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
