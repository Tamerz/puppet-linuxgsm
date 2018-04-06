require 'spec_helper'

describe 'linuxgsm' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }

      describe 'linuxgsm::install' do
        case os_facts[:os]['family']
        when 'Debian'
          it { is_expected.to contain_package('mailutils') }
          it { is_expected.to contain_package('postfix') }
          it { is_expected.to contain_package('curl') }
          it { is_expected.to contain_package('wget') }
          it { is_expected.to contain_package('file') }
          it { is_expected.to contain_package('bzip2') }
          it { is_expected.to contain_package('gzip') }
          it { is_expected.to contain_package('unzip') }
          it { is_expected.to contain_package('bsdmainutils') }
          it { is_expected.to contain_package('python') }
          it { is_expected.to contain_package('util-linux') }
          it { is_expected.to contain_package('ca-certificates') }
          it { is_expected.to contain_package('binutils') }
          it { is_expected.to contain_package('bc') }
          it { is_expected.to contain_package('tmux') }
          it { is_expected.to contain_package('libstdc++6') }
          it { is_expected.to contain_package('lib32z1') }
        end
      end
    end
  end
end
