require 'spec_helper'

describe 'linuxgsm::tf2' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile.with_all_deps }

      it {
        is_expected.to contain_user('tf2server').with(
          'ensure' => 'present',
        )
      }

      it {
        is_expected.to contain_file('/opt/tf2server').with(
          'ensure' => 'directory',
          'owner'  => 'tf2server',
          'group'  => 'tf2server',
        ).that_requires('User[tf2server]')
      }
    end
  end
end
