require 'spec_helper'

describe 'linuxgsm::rust' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile.with_all_deps }

      it { is_expected.to contain_user('rustserver') }
    end
  end
end
