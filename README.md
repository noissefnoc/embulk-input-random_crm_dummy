# Random CRM data generator by Embulk Input plugin

[![Build Status](https://travis-ci.org/noissefnoc/embulk-input-random_crm_dummy.svg?branch=master)](https://travis-ci.org/noissefnoc/embulk-input-random_crm_dummy)
[![MIT License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)][license]

[license]: https://github.com/noissefnoc/embulk-input-random_crm_dummy/blob/master/LICENSE.txt

**WARNING: THIS IS VERY ALPHA VERSION. API OR CONFIGURATION COULD CHANGE.**

Random CRM data generator for [Embulk](https://github.com/embulk/embulk). Expected to used to test or benchmark. 


### NOTE

- This plugin hasn't released rubygemns yet because this is alpha version.
- This plugin currently uses [Faker](https://github.com/stympy/faker) so this plugin supports i18n partially.

## Overview

- **Plugin type**: input
- **Resume supported**: no
- **Cleanup supported**: no
- **Guess supported**: no

## Configuration

- **locale**: description (string, default: `"en"` acceptable locale: [stympy/faker - locales](https://github.com/stympy/faker/tree/master/lib/locales).)
- **rows**: number of inserting rows (long, default: `10`)
- **threads**: number of threads (long, default: `1`)
- **columns**: description (array, required)
    - **type: boolean**
        - return random boolean value 
        - **true_rate**: rate of return true value (double, default: `0.5`)
    - **type: double**
        - return random double value. (config with `dummy` option, specific formatted double value such as latitude and longitude)
        - **dummy**: latitude or longitude (string)
        - **before_point**: place before the decimal point (long, default: `4`)
        - **after_point**: place after the decimal point (long, default: `2`)
    - **type: long**
        - return random long value
        - **from**: minimum of return value (long, default: `0`)
        - **to**: maximum of return value (long, default: `1000000`) 
    - **type: string**
        - return random string value (config with `dummy` option,  specific formatted string value such as phone number, email etc.)
        - **default**: default return string value without `dummy` option (string, default: `This is dummy data.`)
        - **dummy**: phone number, postal code etc. for more detail see `List of string dummy options` below.
    - **type: timestamp**
        - return random timestamp value
        - **from**: start timestamp of return value (date, default: `1970-01-01`)
        - **to**: end timestamp of return value (date, default: `Date.today`)

### List of supported string dummy options

- **city**: city name
- **country**: country name
- **email**: email address (note: currently, email domain for safe)
- **full_name**: first name and last name
- **list**: config with array value `label` option, pick value randomly from `label` array.
- **phone_number**: phone number
- **postal_code**: postal code
- **state**: state name
- **street**: street name
- **url**: URL
- **uuid**: uuid v4

## Example

This is a example of `config.yml`.

```yaml
in:
  type: random_crm_dummy
  columns:
    - {name: AccountSource,          type: string,    dummy: list, label: ['Ad', 'Data.com']}
    - {name: AnnualRevenue,          type: long,      from: 0, to: 10000000000}
    - {name: BillingState,           type: string,    dummy: state}
    - {name: Description,            type: string,    default_string: 'This is default string.'}
    - {name: Industry,               type: string,    dummy: list, label: ['manufacture', 'financial']}
    - {name: IsDeleted,              type: boolean,   true_ratio: 0.9}
    - {name: DeleteDatetime,         type: timestamp, from: '2017-01-01', to: '2017-12-31'}
out:
  type: stdout
```

and gets

```
Ad,7206991348,Hawaii,This is default string.,financial,true,2017-09-30 15:00:00.000000 +0000
Ad,9434694520,Colorado,This is default string.,manufacture,true,2017-01-23 15:00:00.000000 +0000
Ad,9303439532,Oregon,This is default string.,financial,true,2017-06-01 15:00:00.000000 +0000
Data.com,5443621215,South Dakota,This is default string.,manufacture,true,2017-06-19 15:00:00.000000 +0000
Data.com,7653675596,Kansas,This is default string.,financial,true,2017-10-08 15:00:00.000000 +0000
Ad,3533962671,Oregon,This is default string.,financial,true,2017-02-01 15:00:00.000000 +0000
Data.com,6641817856,California,This is default string.,financial,true,2017-04-01 15:00:00.000000 +0000
Data.com,4558029927,Colorado,This is default string.,manufacture,true,2017-12-08 15:00:00.000000 +0000
Data.com,9341647144,Arizona,This is default string.,financial,true,2017-10-12 15:00:00.000000 +0000
Ad,3732589682,New Jersey,This is default string.,financial,true,2017-08-01 15:00:00.000000 +0000
```

For more example, please see [examples folder](https://github.com/noissefnoc/embulk-input-random_crm_dummy/tree/master/examples).


## Installation

This plugin doesn't release rubygems. So clone and build and install step required.

```bash
# clone
$ git clone https://github.com/noissefnoc/embulk-input-random_crm_dummy.git

# build
$ cd embulk-input-random_crm_dummy
$ bundle install   # install one using rbenv & rbenv-build
$ bundle exec rake # build gem

# install
$ embulk gem install pkg/embulk-input-random_crm_dummy-0.1.0.gem
```

## License

This code is free to use under the terms of MIT licence. 
