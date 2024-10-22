title 'software packages'

control 'packages-01' do
    impact 1.0
    title 'packages should be installed'
    desc 'Software packages should be installed'

    describe package('apt-transport-https') do
        it { should be_installed }
    end
end
