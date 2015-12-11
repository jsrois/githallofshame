json.array!(@repos) do |repo|
  json.extract! repo, :id, :name, :size, :has_readme_file
  json.url repo_url(repo, format: :json)
end
