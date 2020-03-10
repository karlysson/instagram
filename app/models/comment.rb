class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates_presence_of :body
  has_rich_text :body
end
