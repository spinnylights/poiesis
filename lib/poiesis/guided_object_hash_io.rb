module GuidedObjectHashIO
  class << self
    def object_hash_io_with_guide(args)
      args[:guide].keys.each do |key|
        if args[:into_obj]
          hash_value_into_object(args[:hash], key, args[:object])
        else
          hash_value_from_object(args[:hash], key, args[:object])
        end
      end
      args[:hash]
    end

    def hash_value_into_object(hash, key, object)
      object.send("#{key}=", hash["#{key}".to_sym])
    end

    def hash_value_from_object(hash, key, object)
      hash["#{key}".to_sym] =  object.send("#{key}")
    end
  end
end
