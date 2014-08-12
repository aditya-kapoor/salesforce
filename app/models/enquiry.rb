class Enquiry
  include ActiveModel::Model

  attr_accessor :first_name, :last_name, :email, :phone_number, :message

  def save(attributes)
    # SalesForceEnquiry.create(salesforce_attributes(attributes))
  # rescue Databasedotcom::SalesForceError => error
  #   Rails.logger.info error.message
  #   populate_errors(error.message)
  #   false
    contact = load_contact(attributes[:email], attributes[:last_name])
    Rails.logger.info "Creating Case for Contact : #{contact}"
    SalesForceCase.create({ContactId: contact.Id, Subject: attributes[:message]})
  end

  private

    def salesforce_attributes(attributes)
      attributes.keys.each { |key| attributes["#{key}__c"] = attributes.delete(key) }
      attributes
    end

    def populate_errors(salesforce_api_message)
      # TODO: Cleanup this...
      salesforce_api_message.gsub!('first_name__c', 'first_name')
      salesforce_api_message.gsub!('last_name__c', 'first_name')
      salesforce_api_message.gsub!('email__c', 'first_name')
      errors.add(:base, salesforce_api_message)
    end

    def load_contact(email, last_name)
      Rails.logger.info "Fetching contact by #{email}"
      contact = SalesForceContact.find_by_email(email)
      contact = SalesForceContact.create({Email: email, LastName: last_name}) unless contact
      contact
    end
end