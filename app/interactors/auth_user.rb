class AuthUser
  include Interactor

  before :check_token

  def call
    begin
      decoded_info = JWT.decode(context.token, ENV['SECRET_KEY'])[0]
    rescue JWT::DecodeError
      context.fail!(error: I18n.t('auth.decode_token_error'))
    end
    context.user = User.find_by_login(decoded_info['login'])
    context.fail!(error: I18n.t('user.not_found')) if context.user.nil?
  end

  private

  def check_token
    context.fail!(error: I18n.t('auth.token_not_found')) if context.token.blank?
  end

end