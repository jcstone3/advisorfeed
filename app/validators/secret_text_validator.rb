class SecretTextValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    #get stored record and compare with the passed value
    user = User.find_by_id(record[:id])
    unless value.downcase == user.secret_text.downcase
      record.errors[attribute] << (options[:message] || "Secret Code not matching")
    end
  end
end
