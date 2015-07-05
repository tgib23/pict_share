#coding: utf-8

class NoticeMailer < ActionMailer::Base
  default from: "satoshi@pictcollect.link"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notice_mailer.sendmail_confirm.subject
  #
  def sendmail_confirm(user, from, title, contents)
    @user = user
	@from = from
	@title = title
	@contents = contents
    mail( to: "pictcollect@gmail.com",
	      :subject => @title)
  end
end
