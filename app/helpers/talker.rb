class Talker
  def initialize(user)
    @user = user
  end

  def reply(options = {})
    FacebookService.new.send_message(@user, determine_message(options))
  end

  private

  def determine_message(options = {})
    # last_message_from_user = options[:to] || @user.messages_sent_to_my_page

    # Use a very simple reply for now
    "Thank you for sending this message" + (@user.name ? ", #{@user.name.split(' ').first}!" : "!")
  end
end
