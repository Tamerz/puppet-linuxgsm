require 'spec_helper'

describe 'linuxgsm' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile.with_all_deps }

      describe 'linuxgsm::install' do
        it { is_expected.to contain_package('postfix') }
        it { is_expected.to contain_package('curl') }
        it { is_expected.to contain_package('wget') }
        it { is_expected.to contain_package('bzip2') }
        it { is_expected.to contain_package('gzip') }
        it { is_expected.to contain_package('unzip') }
        it { is_expected.to contain_package('python') }
        it { is_expected.to contain_package('binutils') }
        it { is_expected.to contain_package('bc') }
        it { is_expected.to contain_package('jq') }
        it { is_expected.to contain_package('tmux') }

        case os_facts[:os]['family']
        when 'Debian'
          it { is_expected.to contain_package('mailutils') }
          it { is_expected.to contain_package('file') }
          it { is_expected.to contain_package('bsdmainutils') }
          it { is_expected.to contain_package('util-linux') }
          it { is_expected.to contain_package('ca-certificates') }
          it { is_expected.to contain_package('libstdc++6') }
          it { is_expected.to contain_package('lib32z1') }

          context 'on Debian family amd64' do
            if os_facts[:architecture] == 'amd64'
              it { is_expected.to contain_package('lib32gcc1').that_requires('Exec[add_multiarch]') }
              it { is_expected.to contain_package('libstdc++6:i386').that_requires('Exec[add_multiarch]') }
              it {
                is_expected.to contain_exec('add_multiarch').with(
                  'command' => '/usr/bin/dpkg --add-architecture i386 && /usr/bin/apt-get update -q',
                  'unless'  => "/bin/grep 'i386' /var/lib/dpkg/arch",
                )
              }
            end
          end

        when 'RedHat'
          it { is_expected.to contain_package('mailx') }

          context 'on RedHat family x86_64' do
            if os_facts[:architecture] == 'x86_64'
              it { is_expected.to contain_package('glibc.i686') }
              it { is_expected.to contain_package('libstdc++.i686') }
            end
          end

          context 'on Fedora' do
            if os_facts[:os]['name'] == 'Fedora'
              it { is_expected.to contain_package('file') }
            end
          end
        end
      end
    end
  end
end
