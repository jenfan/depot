class SayController < ApplicationController
  def hello
  end

  def goodbye
  	@files = Dir.glob('*')
  end
end
