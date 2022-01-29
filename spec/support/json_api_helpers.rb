# frozen_string_literal: true

module JsonApiHelpers
	def parsed_body
		JSON.parse(response.body)
	end

	def parsed_data
		parsed_body['data']
	end
end