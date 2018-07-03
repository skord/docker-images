require 'yaml'


CONFIG = YAML.load_file('config.yml')

namespace :build do
  desc "build garbd"
  task :garbd do
    sh "docker build -t garbd garbd"
  end

  desc "build mariadb 10.1-alpine"
  task :mariadb_alpine do
    sh "docker build -t mariadb:10.1-alpine mariadb-alpine"
  end

  namespace :maxscale do
    desc "MaxScale Latest"
    task :latest do
      dockerfile = File.read("maxscale/Dockerfile")
      new_dockerfile = dockerfile.
        gsub(/^ENV MAXSCALE_VERSION.*/,"ENV MAXSCALE_VERSION=#{CONFIG['maxscale_version']}").
        gsub(/^ENV MAXSCALE_PACKAGE_VERSION.*/,"ENV MAXSCALE_PACKAGE_VERSION=#{CONFIG['maxscale_package_version']}")
      File.open("maxscale/latest/Dockerfile","w") do |file|
        file << new_dockerfile
      end
    end

  end
end

