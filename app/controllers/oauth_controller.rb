class OauthController < ApplicationController

    @@user_ids      = Hash.new

    private def get_access_token_response(code)
        url = "https://discord.com/api/oauth2/token"

        response = RestClient.post(url,
            {
                'client_id'     => ENV['discord_oauth_client_id'],
                'client_secret' => ENV['discord_oauth_client_secret'],
                'grant_type'    => 'authorization_code',
                'code'          => code,
                'redirect_uri'  => ENV['discord_oauth_redirect_uri'],
            },
        )

        return JSON.parse(response.body)
    end

    private def store_access_token_response(response)
        session[:access_token]  = response['access_token']
        session[:expires_in]    = response['expires_in']
        session[:refresh_token] = response['refresh_token']
    end

    def self.get_me(session)
        access_token = session[:access_token]
        if access_token == nil
            return nil
        end

        url = "https://discord.com/api/users/@me"
        response = RestClient.get(url, :Authorization => 'Bearer ' + access_token)
        return JSON.parse(response.body)
    end

    private def get_user_id()
        me = self.get_me(session)
        return me['id']
    end

    def authenticate
        store_access_token_response(get_access_token_response(params[:code]))
        redirect_to authenticated_path
    end

end
