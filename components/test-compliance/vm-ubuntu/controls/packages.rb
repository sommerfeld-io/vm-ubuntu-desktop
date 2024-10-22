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
        'docker-ce'
        'docker-ce-cli'
        'containerd.io'
        'docker-buildx-plugin'
        'docker-compose-plugin'
        'inspec'
    )
    PACKAGES.each do |p|
        describe package(p) do
            it { should be_installed }
        end
    end
end

control 'packages-02' do
    impact 0.5
    title 'Snap packages should be installed'
    desc 'Snap packages should be installed'

    SNAPS = %w(
        '/snap/bin/code'
    )
    SNAPS.each do |s|
        describe file(s) do
            it { should exist }
            it { should be_file }
            it { should_not be_directory }
            it { should be_executable }
        end
    end
end

control 'packages-03' do
    impact 1.0
    title 'Binary commands should be installed'
    desc 'Software packages run from binary commands should be installed'

    COMMANDS = %w(
        '/usr/local/bin/helm'
        '/usr/local/bin/minikube'
    )
    COMMANDS.each do |c|
        describe file(c) do
            it { should exist }
            it { should_not be_directory }
        end
    end
end
