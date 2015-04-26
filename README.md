# RSpec formatters
Custom and modified RSpec 3 formatters.

## Usage
1. Clone this repository to `~/.rspec-formatters`.
2. Require the formatter's Ruby file using RSpec's `--require` flag.
3. Set the formatter to the formatter's class name using RSpec's `--format` flag.

```
rspec --require ~/.rspec-formatters/nc_with_coverage.rb --format NcWithCoverage
rspec -r ~/.rspec-formatters/nc_with_coverage.rb -f NcWithCoverage
```
