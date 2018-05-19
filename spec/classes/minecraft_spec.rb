require 'spec_helper'

describe 'linuxgsm::minecraft' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile.with_all_deps }

      case os_facts[:os]['family']
      when 'Debian'
        it { is_expected.to contain_package('default-jdk') }
      when 'RedHat'
        it { is_expected.to contain_package('java-1.8.0-openjdk') }
      end
    end
  end
end
