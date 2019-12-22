class Project < ApplicationRecord
  belongs_to :user

  PROJECT_TYPES = {:public=>'public',:private=>'private'}
  validates :name, presence: true, length: { minimum: 4, maximum: 50  }
  validates :project_type, presence: true, inclusion: { in: PROJECT_TYPES.values, message: 'unrecognized or unselected'}

  def is_public?
    self.project_type == PROJECT_TYPES[:public]
  end

  def is_private?
    self.project_type == PROJECT_TYPES[:private]
  end
end
