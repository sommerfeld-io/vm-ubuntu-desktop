title 'software packages'

control 'packages-01' do
    impact 1.0
    title 'Packages should be installed'
    desc 'Software packages should be installed'

    PACKAGES = %w(
        'apt-transport-https'
        'ca-certificates'
        'curl'
        'gnupg'
        'lsb-release'
        'git'
        'tilix'
        'tmux'
        'vim'
        'ncdu'
        'neofetch'
        'htop'
        'jq'
        'code'
        'docker-ce'
        'docker-ce-cli'
        'containerd.io'
        'docker-buildx-plugin'
        'docker-compose-plugin'
        'minikube'
        'helm'
        'inspec'
    )
    PACKAGES.each do |p|
        describe package(p) do
            it { should be_installed }
        end
    end
end
