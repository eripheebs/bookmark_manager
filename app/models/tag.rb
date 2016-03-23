require_relative '../data_mapper_setup'

class Tag
  include DataMapper::Resource

  property :id, Serial
  property :tag, String

  has n, :links, :through => Resource

  def self.make_tags(string)
    string.split(', ')
  end
end
