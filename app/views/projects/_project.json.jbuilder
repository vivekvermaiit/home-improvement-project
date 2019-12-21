json.extract! project, :id, :name, :project_type, :description, :created_at, :updated_at
json.url project_url(project, format: :json)
