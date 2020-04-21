class ContentfulCustomJsonValidator < ActiveModel::Validator
  def validate(record)
    return if record.json.nil?
    if record.json.keys != ["custom_json"]
      record.errors.add(:json, 'Must be a custom_json format. Use ContentfulCustomJson class to format json correctly')
    end
  end
end
