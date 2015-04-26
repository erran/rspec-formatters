# Inspired by https://github.com/cupakromer/emoji-rspec#books which lacked
# support for RSpec 3.2 when I wrote this.
require 'rspec/core/formatters/base_text_formatter'

class BooksFormatter < RSpec::Core::Formatters::BaseTextFormatter
  RSpec::Core::Formatters.register self,
    :example_failed,
    :example_passed,
    :example_pending,
    :start_dump

  def example_failed(_notification)
    output.print '📕 '
  end

  def example_passed(_notification)
    output.print '📗 '
  end

  def example_pending(_notification)
    output.print '📙 '
  end

  def start_dump(_notification)
    output.puts
  end
end

Books = BooksFormatter unless defined?(Books)
