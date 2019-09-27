

def Artist

  attr_accessor :name
  attr_reader :id

  def initialize(details)
    @id = details['id'] if details['id']
    @name = details['id']
  end

end
