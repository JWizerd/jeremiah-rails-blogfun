class Article < ActiveRecord::Base
  # has_many allows for association between the article and its comments (comments have a seperate model and database table.
  # dependent: :destroy allows all comments for an article to be detsroyed when an article is deleted. 
  has_many :comments, dependent: :destroy
  validates :title, presence: true, length: { minimum: 5 }
  validates :text, presence: true, length: { minimum: 30 }
end
