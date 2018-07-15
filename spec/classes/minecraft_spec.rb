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

        it {
          is_expected.to contain_firewalld_port('minecraft').with(
            'ensure'   => 'present',
            'zone'     => 'public',
            'port'     => 25565,
            'protocol' => 'tcp',
          )
        }
      end

      it {
        is_expected.to contain_user('mcserver').with(
          'ensure' => 'present',
        )
      }

      it {
        is_expected.to contain_file('/opt/mcserver').with(
          'ensure' => 'directory',
          'owner'  => 'mcserver',
          'group'  => 'mcserver',
        ).that_requires('User[mcserver]')
      }

      it {
        is_expected.to contain_exec('install_mcserver').with(
          'command' => '/usr/bin/wget https://linuxgsm.com/dl/linuxgsm.sh && chmod +x linuxgsm.sh && bash linuxgsm.sh mcserver && ./mcserver ai',
          'cwd'     => '/opt/mcserver',
          'creates' => '/opt/mcserver/mcserver',
          'timeout' => 0,
        )
      }
    end
  end
end
