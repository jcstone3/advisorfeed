class SecretTextValidator < ActiveModel::EachValidator
  include DeviseInvitable::Inviter

  attr_accessor :secret_text

  def validate_each(record, attribute, value)

    unless value == record[:secret_text]
      record.errors[attribute] << (options[:message] || "Secret text not matching")
    end
  end
end
