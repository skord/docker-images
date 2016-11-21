MAXSCALE_VERSION="2.0.1"
MAXSCALE_PACKAGE_VERSION="#{MAXSCALE_VERSION}-2"
desc "build everything"
task :build => ['build:mdba', 'build:mdbac', 'build:maxscale', 'build:maxscale_edge_consul', 'build:maxscale_consul']
desc "build and push"
task :release => [:build,:push]

namespace :build do
  desc "mariadb 10.1 alpine"
  task :mdba do
    sh "docker build -t skord/mariadb:10.1-alpine mariadb-alpine/10.1"
    sh "docker tag skord/mariadb:10.1-alpine skord/mariadb:latest"
  end
  desc "mariadb 10.1 alpine consul"
  task :mdbac do
    sh 'docker build -t skord/mariadb:10.1-alpine-consul mariadb-alpine-consul/10.1'
  end
  desc "maxscale"
  task :maxscale do
    write_package_to_dockerfile("maxscale")
    sh "docker build -t skord/maxscale:#{MAXSCALE_VERSION} maxscale"
    sh "docker tag skord/maxscale:#{MAXSCALE_VERSION} skord/maxscale:latest"
  end
  desc "maxscale-consul"
  task :maxscale_consul do
    write_package_to_dockerfile("maxscale-consul")
    sh "docker build -t skord/maxscale:#{MAXSCALE_VERSION}-consul maxscale-consul"
    sh "docker tag skord/maxscale:#{MAXSCALE_VERSION}-consul skord/maxscale:consul"
  end
  desc "maxscale-edge"
  task :maxscale_edge do
    sh 'docker build --no-cache -t skord/maxscale:edge maxscale-edge'
  end
  desc "maxscale-edge-consul"
  task :maxscale_edge_consul => :maxscale_edge do
    sh 'docker build -t skord/maxscale:edge-consul maxscale-edge-consul'
  end
end

def write_package_to_dockerfile(dir)
  dockerfile = File.read(File.join(dir, "Dockerfile"))
  new_contents = dockerfile.gsub(/MAXSCALE_PACKAGE_VERSION=[\d\.-]{1,}/,"MAXSCALE_PACKAGE_VERSION=#{MAXSCALE_PACKAGE_VERSION}")
  File.open("#{dir}/Dockerfile","w") do |file|
    file << new_contents
  end
end

desc "push everything"
task :push do
  sh 'docker push skord/mariadb:latest'
  sh 'docker push skord/mariadb:10.1-alpine'
  sh 'docker push skord/mariadb:10.1-alpine-consul'
  sh "docker push skord/maxscale:latest"
  sh "docker push skord/maxscale:#{MAXSCALE_VERSION}"
  sh "docker push skord/maxscale:#{MAXSCALE_VERSION}-consul"
  sh "docker push skord/maxscale:consul"
  sh 'docker push skord/maxscale:edge'
  sh 'docker push skord/maxscale:edge-consul'
end
