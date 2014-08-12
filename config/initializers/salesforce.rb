
# use host option if you have your app in the sandbox mode...
SalesForceClient = Databasedotcom::Client.new(client_id: Rails.application.secrets.salesforce['client_id'], 
                                              client_secret: Rails.application.secrets.salesforce['client_secret'])

SalesForceClient.authenticate(username: Rails.application.secrets.salesforce['username'], password: Rails.application.secrets.salesforce['password'])
SalesForceEnquiry = SalesForceClient.materialize("Enquiry__c")
SalesForceContact = SalesForceClient.materialize("Contact")
SalesForceCase    = SalesForceClient.materialize("Case")
