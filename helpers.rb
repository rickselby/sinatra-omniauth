# frozen_string_literal: true

# Helper functions for sinatra
module Helpers
  def logged_in?
    session.key?(:user) && !session.fetch(:user).empty?
  end
end
