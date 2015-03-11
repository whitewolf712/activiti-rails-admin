# Get servers from yaml file

Rails.application.config.activiti_api_servers = YAML.load_file('config/servers.yml')