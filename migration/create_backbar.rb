require 'aws-record'
require_relative './backbar.rb'
Aws.config.update(endpoint: ENV['DYNAMODB_ENDPOINT']) if ENV.has_key?('DYNAMODB_ENDPOINT')

cfg = Aws::Record::TableConfig.define do |t|
  t.model_class(Backbar)
  t.read_capacity_units(2)
  t.write_capacity_units(2)

	t.global_secondary_index(:gsi_keywords) do |i|
    i.read_capacity_units(2)
    i.write_capacity_units(2)
  end
end

cfg.migrate!