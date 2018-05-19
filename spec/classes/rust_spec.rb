require 'spec_helper'

describe 'linuxgsm::rust' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile.with_all_deps }

      it {
        is_expected.to contain_user('rustserver').with(
          'ensure' => 'present',
        )
      }

      it {
        is_expected.to contain_file('/opt/rustserver').with(
          'ensure' => 'directory',
          'owner'  => 'rustserver',
          'group'  => 'rustserver',
        ).that_requires('User[rustserver]')
      }

      it {
        is_expected.to contain_exec('install_rustserver').with(
          'command' => '/usr/bin/wget https://linuxgsm.com/dl/linuxgsm.sh && chmod +x linuxgsm.sh && bash linuxgsm.sh rustserver && ./rustserver ai',
          'cwd'     => '/opt/rustserver',
          'creates' => '/opt/rustserver/rustserver',
          'timeout' => 0,
        )
      }
    end
  end
end
