class Project < ApplicationRecord
  belongs_to :user

  PROJECT_TYPES = ['public','private']
  validates :name, presence: true, length: { minimum: 4, maximum: 50  }
  validates :project_type, presence: true, inclusion: { in: PROJECT_TYPES}
end
