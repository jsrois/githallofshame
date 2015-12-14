class Repo < ActiveRecord::Base
    validates :name, presence: true
    
    def self.update_from_server!
        remote_data = get_remote_data
        repos = get_repos_from_remote_data(remote_data)
    end
 private 
 
    def self.make_get_request_to_stash_api(request_route)
        params = YAML::load(File.open(Rails.root.to_s + "/config/config.yml"))
        uri = URI.parse(params["stash_url"] + request_route)
        http = Net::HTTP.new(uri.host, uri.port)
        req = Net::HTTP::Get.new(uri.request_uri)
        req.basic_auth(params["stash_user"], params["stash_pass"])
        http.use_ssl = (uri.scheme == "https")
        http.request(req)
    end
    
    def self.get_remote_data
        make_get_request_to_stash_api("/rest/api/1.0/repos?limit=10").body
    end
    MEGABYTE = 1024 * 1024
    
    def self.get_repos_from_remote_data (data)
        slugs = JSON.parse(data)["values"].map {|v| {:name => v["slug"], :project_name => v["project"]["name"], :project_key => v["project"]["key"]} }
        slugs.each do
            |s|
            # update size
            size = JSON.parse(make_get_request_to_stash_api("/rest/reposize/latest/projects/" + s[:project_key] + "/repos/" + s[:name]).body)["sizeRaw"].to_f/(MEGABYTE)
            has_readme = JSON.parse(make_get_request_to_stash_api("/rest/api/1.0/projects/" + s[:project_key] + "/repos/"+s[:name]+"/browse/READM.md?type=true").body).has_key?("type")
            repo = Repo.find_or_initialize_by({:name => s[:name]})
            repo.update({:size => size.round(2), :has_readme_file => has_readme })
            repo.save
        end
    end
end
