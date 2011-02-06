class TikkokController < ApplicationController
  require 'mail'
  skip_before_filter :verify_authenticity_token

  def index
    @tikkoks = Tikkok.findForDay
    render :index
  end

  def create
    message = Mail.new(params[:message])
    puts message.body.to_yaml_style
    begin
      Tikkok.create(:title => message.subject,
                    :body => message.body.to_s.encode('utf-8'))
      if Tikkok.save
        puts 'saved'
        render :text => "ok"
      else
        puts 'fail to save'
        render :text => "fail to save"
      end
    rescue
      puts "some error has occurred"
      render :text => "some error has occurred"
    end
  end

end
