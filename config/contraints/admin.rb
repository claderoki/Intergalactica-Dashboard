class AdminConstraint
    ADMIN_USER_IDS = [120566758091259906, 247855177074212865, 841255759978954763]

    def matches?(request)
      me = OauthController::get_me(request.session)
      return ADMIN_USER_IDS.include?(Integer(me['id']))
    end
  end