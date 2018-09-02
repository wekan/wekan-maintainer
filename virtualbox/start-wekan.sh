# If you want to restart even on crash, uncomment while and done lines.

#while true; do
	cd ~/repos/wekan/.build/bundle
	export MONGO_URL='mongodb://127.0.0.1:27017/admin'
	# Production: https://example.com/wekan
	# Local: http://localhost:3000
	#export ipaddress=$(ifdata -pa eth0)
	export ROOT_URL='http://localhost'
	# https://github.com/wekan/wekan/wiki/Troubleshooting-Mail
	# https://github.com/wekan/wekan-mongodb/blob/master/docker-compose.yml
	export MAIL_URL='smtp://user:pass@mailserver.example.com:25/'
	export MAIL_FROM='Wekan Support <support@example.com>'
	# This is local port where Wekan Node.js runs, same as below on Caddyfile settings.
	export PORT=80
	# Wekan Export Board works when WITH_API='true'.
        # If you disable Wekan API, Export Board does not work.
	export WITH_API='true'
        ## Optional: Integration with Matomo https://matomo.org that is installed to your server
        ## The address of the server where Matomo is hosted:
        # export MATOMO_ADDRESS='https://example.com/matomo'
        export MATOMO_ADDRESS=''
        ## The value of the site ID given in Matomo server for Wekan
        # export MATOMO_SITE_ID='123456789'
        export MATOMO_SITE_ID=''
        ## The option do not track which enables users to not be tracked by matomo"
        # export MATOMO_DO_NOT_TRACK='false'
        export MATOMO_DO_NOT_TRACK='true'
        ## The option that allows matomo to retrieve the username:
        # export MATOMO_WITH_USERNAME='true'
        export MATOMO_WITH_USERNAME='false'
        # Enable browser policy and allow one trusted URL that can have iframe that has Wekan embedded inside.
	# Setting this to false is not recommended, it also disables all other browser policy protections
	# and allows all iframing etc. See wekan/server/policy.js
	# Default value: true
	export BROWSER_POLICY_ENABLED=true
        # When browser policy is enabled, HTML code at this Trusted URL can have iframe that embeds Wekan inside.
	# Example: export TRUSTED_URL=http://example.com
        export TRUSTED_URL=''
        # What to send to Outgoing Webhook, or leave out. Example, that includes all that are default: cardId,listId,oldListId,boardId,comment,user,card,commentId .
        # Example: export WEBHOOKS_ATTRIBUTES=cardId,listId,oldListId,boardId,comment,user,card,commentId
	export WEBHOOKS_ATTRIBUTES=''
	node main.js & >> ~/repos/wekan.log
	cd ~/repos
#done
