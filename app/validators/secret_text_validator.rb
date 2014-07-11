class SecretTextValidator < ActiveModel::EachValidator
  include DeviseInvitable::Inviter

  attr_accessor :secret_text

  def validate_each(record, attribute, value)
    Rails.logger.debug "custom validatior ----------------------------------------"
    Rails.logger.debug record.inspect
    Rails.logger.debug attribute.inspect
    Rails.logger.debug value.inspect
    Rails.logger.debug record[:secret_text].inspect

    unless value == record[:secret_text]
      record.errors[attribute] << (options[:message] || "Secret text not matching")
    end
  end
end
