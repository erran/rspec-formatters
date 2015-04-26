# Based on https://github.com/twe4ked/rspec-nc/blob/456ba012e9c45399b23596572386fb0a6c61bfb7/lib/nc.rb
# Adds an execute callback to open the Coverage report.
require 'rspec/core/formatters/base_text_formatter'
require 'rspec/core/notifications'
require 'terminal-notifier'

class NcWithCoverage < RSpec::Core::Formatters::BaseTextFormatter
  RSpec::Core::Formatters.register self, :dump_summary

  SizeResponder = Struct.new(:size)

  attr_reader :output

  def dump_pending(*); end
  def dump_failures(*); end
  def message(*); end

  def dump_summary(notification)
    summary = summary_for(notification)
    title = title_for(
      File.basename(File.expand_path('.')),
      notification.failure_count
    )

    body = "#{summary.totals_line}\n#{summary.formatted_duration}"
    file = File.expand_path('./coverage/rcov/index.html')
    open_coverage_command = "test -e #{file} && open file://#{file}"

    notify title, body, execute: open_coverage_command
  end

  private

  def notify(title, body, options = {})
    options.merge!(title: title)
    TerminalNotifier.notify body, options
  end

  def summary_for(notification)
    RSpec::Core::Notifications::SummaryNotification.new(
      notification.duration,
      SizeResponder.new(notification.example_count),
      SizeResponder.new(notification.failure_count),
      SizeResponder.new(notification.pending_count),
      notification.load_time
    )
  end

  def title_for(name, failure_count)
    if failure_count > 0
      "\u26D4 #{name}: #{failure_count} failed example#{'s' if failure_count == 1}"
    else
      "\u2705 #{name}: Success"
    end
  end
end
