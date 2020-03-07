class Post < ApplicationRecord

  belongs_to :created_by, class_name: "User"

  validates_presence_of :description
end
