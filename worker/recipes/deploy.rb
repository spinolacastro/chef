include_recipe 'deploy'

  gem_package "webrick" do
    action :install
  end

node[:deploy].each do |application, deploy|
  opsworks_deploy_dir do
    user deploy[:user]
    group deploy[:group]
    path deploy[:deploy_to]
  end

  opsworks_deploy do
    deploy_data deploy
    app application
  end

  link webapp_dir do
    to current_dir
    action :create
  end
end