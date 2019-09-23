require 'aws-record'

class Backbar
	include Aws::Record
	string_attr :name, hash_key: true
	string_attr :keywords
	string_attr :material
	string_attr :recepe
	string_attr :tips
	date_attr :updated_at

	global_secondary_index(
		:gsi_keywords,
		hash_key: :keywords,
		range_key: :name,
		projection: {
			projection_type: 'ALL'
		}
	)
end