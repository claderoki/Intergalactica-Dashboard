class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    private
    def current_user
        me = OauthController::get_me(session)
        if me == nil
            return nil
        end
        return User.new(me['id'], me['username'], me['avatar'])
    end
    helper_method :current_user

    protect_from_forgery with: :exception
    private
    def discord_oauth_url
        url = 'https://discord.com/api/oauth2/authorize?client_id='
        url += ENV['discord_oauth_client_id']
        url += '&redirect_uri='
        url += request.protocol + request.host_with_port + '/authenticate'
        return url + '&response_type=code&scope=identify'
    end
    helper_method :discord_oauth_url

end
