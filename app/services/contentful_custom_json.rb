class ContentfulCustomJson
  attr_reader :custom_json

  def initialize(hash_fields, hash_includes)
    @custom_json = convert_to_custom_json(hash_fields, hash_includes)
  end

  def convert_to_custom_json(hash_fields, hash_includes)
    parsed_json = Hash.new
    parsed_json[:content_type_id] = hash_fields[:sys][:contentType][:sys][:id]
    parsed_json[:contentful_id] = hash_fields[:sys][:id]
    parsed_json[:fields] = {}
    parse_fields(hash_fields[:fields], parsed_json[:fields], hash_includes)

    return parsed_json
  end

  def parse_fields(hash_with_fields, parent_hash, hash_with_includes)
    hash_with_fields.each do |k, v|
      case v.class.to_s
        when 'Array'
          parent_hash[k] = []
          v.each do |array_item|
            hash_item = Hash.new
            if array_item.dig(:sys, :linkType) == "Entry"
              #find_included entry
              hash_with_includes[:Entry].each do |entry|
                if entry.dig(:sys, :id) == array_item.dig(:sys, :id)
                  hash_item[:items] = Hash.new
                  parse_fields(entry[:fields], hash_item[:items], hash_with_includes)
                  break
                end
              end
            elsif array_item.dig(:sys, :linkType) == "Asset"
              #find_included asset
              hash_with_includes[:Asset].each do |asset|
                if asset.dig(:sys, :id) == array_item.dig(:sys, :id)
                  hash_item[:items] = Hash.new
                  parse_fields(asset[:fields], hash_item[:items], hash_with_includes)
                  break
                end
              end
            else
              #single entry inside a hash, without linked entries
              hash_item[:items] = array_item
            end

            parent_hash[k] << hash_item[:items]
          end
        when 'Hash'
          if hash_with_fields[k].dig(:sys, :linkType) == "Entry"
            #find_included entry
            hash_with_includes[:Entry].each do |entry|
              if entry.dig(:sys, :id) == hash_with_fields[k].dig(:sys, :id)
                parent_hash[k] = Hash.new
                parent_hash[k][:id] = entry[:sys][:id]
                parent_hash[k][:type] = entry[:sys][:type]
                parent_hash[k][:content_type_id] = entry[:sys][:contentType][:sys][:id]
                parse_fields(entry[:fields], parent_hash[k], hash_with_includes)
                break
              end
            end
          elsif hash_with_fields[k].dig(:sys, :linkType) == "Asset"
            #find_included asset
            hash_with_includes[:Asset].each do |asset|
              if asset.dig(:sys, :id) == hash_with_fields[k].dig(:sys, :id)
                parent_hash[k] = Hash.new
                parent_hash[k][:id] = asset[:sys][:id]
                parent_hash[k][:type] = asset[:sys][:type]
                parse_fields(asset[:fields], parent_hash[k], hash_with_includes)
                break
              end
            end
          else
            #single entry inside a hash, without linked entries
            parent_hash[k] = v
          end
        else
          #single entry, without linked entries
          parent_hash[k] = v
      end
    end
  end
end
