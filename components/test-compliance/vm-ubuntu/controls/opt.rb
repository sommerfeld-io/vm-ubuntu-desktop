title "/opt/vm-ubuntu checks"

control "opt-01" do
    impact 0.7
    title "Files should exist and should have correct permissions"
    desc "Check if files exist and have the correct permissions."

    FILES = %w(
        '/opt/vm-ubuntu/minikube-startup.sh'
        '/opt/vm-ubuntu/minikube-shutdown.sh'
        '/opt/vm-ubuntu/minikube-delete.sh'
    )
    FILES.each do |folder|
        describe file(folder) do
            it { should exist }
            it { should be_file }
            it { should_not be_directory }
            it { should be_readable }
            it { should be_writable.by('owner') }
            it { should_not be_writable.by('group') }
            it { should_not be_writable.by('others') }
            it { should be_executable }
        end
    end
end
