require 'httparty'
require 'json'
require './lib/roadmap'


class Kele
    include HTTParty
    include MyRoadMap

  def initialize(email, password)
      response = self.class.post('https://www.bloc.io/api/v1/sessions', body: { "email": email, "password": password })
      raise 'Invalid Email and/or Password' if response.code != 200
      @auth_token = response["auth_token"]
  end
  
  def get_me 
      response = self.class.get('https://www.bloc.io/api/v1/users/me', headers: { "authorization" => @auth_token })
      @user_me = JSON.parse(response.body)
  end
  
  def get_mentor_availability(mentor_id)
      response = self.class.get("https://www.bloc.io/api/v1/mentors/#{mentor_id}/student_availability", headers: { "authorization" => @auth_token })
      @mentor_availability = JSON.parse(response.body)
  end
  
  def get_messages(page_number)
      response = self.class.get("https://www.bloc.io/api/v1/message_threads?page=#{page_number}", headers: { "authorization" => @auth_token })
      @messages = JSON.parse(response.body)
  end
  
  def create_message(email, recipient_id, token, subject, message)
      response = self.class.post("https://www.bloc.io/api/v1/messages", body: { "sender": email, "recipient_id": recipient_id, "token": token, "subject": subject, "stripped-text": message }, headers: { "authorization" => @auth_token })
      puts response
  end
  
  def create_submissions(checkpoint_id, assignment_branch, assignment_commit_link, comment, enrollment_id)
    response = self.class.post("https://www.bloc.io/api/v1/checkpoint_submissions", body: { "checkpoint_id": checkpoint_id, "assignment_branch": assignment_branch, "assignment_commit_link": assignment_commit_link, "comment": comment, "enrollment_id": enrollment_id }, headers: { "authorization" => @auth_token })
    puts response
  end
  
end


  
  
  
