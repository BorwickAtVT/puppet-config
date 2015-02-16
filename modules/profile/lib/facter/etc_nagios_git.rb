require 'facter'

Facter.add(:etc_nagios_git) do
  setcode do
    if File.directory? '/etc/nagios/.git'
      true
    else
      false
    end
  end
end
