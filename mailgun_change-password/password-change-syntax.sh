#####
# need to go to:
# Mailgun --> Settings --> API Keys --> Private API Key
# to find the API key for here
curl -s --user 'api:key-BLAH' -X PUT -G https://api.mailgun.net/v3/domains/example.com/credentials/whatever-name@example.com -F password="BLAH"
