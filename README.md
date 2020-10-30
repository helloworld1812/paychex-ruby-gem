# Paychex

Ruby toolkit for [Paychex APIs](https://developer.paychex.com/api-documentation-and-exploration/api-references).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'paychex'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install paychex

## Usage

```
# Require the toolkit
require "paychex"

# Get an instance of Paychex::Client
client = Paychex.client()

# Before any other API call do call authorize
client.authorize({
  grant_type: "client_credentials",
  client_id: "c22",
  client_secret: "8f6a4213",
})

# Fetch all the linked commpanies
client.linked_companies()

# Fetch profile for individual company
client.linked_company(company_id)

# Fetch all workers associated with a company
client.workers(company_id)

# Fetch workers with pagination support
client.workers(company_id, {
  limit: 20,  # indicates total number of workers to be given in a response
              # Un-documented on Paychex but limit value is capped at 20
  offset: 0,  # zero based index to start showing workers
              # if 5 is passed, the response will display from 6th worker
})

# Fetch a specific worker's profile
client.worker(worker_id)

# Fetch jobs for a company
client.jobs(company_id)

# Fetch a specific job of a company
client.job(company_id, job_id)

# Fetch locations for a company
client.locations(company_id)

# Fetch locations with asof option for a company
client.locations(company_id, {
  asof: "2019-01-18T00:00:00Z"  # This will give location/locations data for
                                # that particular date.
})

# Fetch a specific location of a company
client.location(company_id, location_id)
# Sepcific location method can also be sent the option of asof like in
# locations method.
```

Fetching of workers supports more options along with paginations. For more
details refer to the [workers documentation](https://developer.paychex.com/api-documentation-and-exploration/api-references/workers).

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Future

- Pending collection APIs for workers
  - laborassignments

- All other APIs which do inserts or updates.

- Give all static dropdown options as collection or constants
  - workerType
  - employmentType
  - exemptionType
  - sex
  - statusType
  - statusReason - values are based on statusType
  - legalIdType

- Fix usage of application/x-www-form-urlencoded content type for auth
- Make host and endpoint URLs support staging and production servers based on
  environment configuration parameter
- Handle token expiry by refreshing
- Add support for auto-pagination and start using per_page configuration

## Play Around

To experiment with that code, run `bin/console` for an interactive prompt.

## Contributing

Any Ruby code should go in the `lib` directory.
Bug reports and pull requests are welcome on GitHub at https://github.com/helloworld1812/paychex. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/helloworld1812/paychex/blob/master/CODE_OF_CONDUCT.md).



## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Paychex project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/helloworld1812/paychex/blob/master/CODE_OF_CONDUCT.md).
