versions = node[:kernel][:release].match(/(\d\.\d)\.(\d*)/).to_a

major_minor_version = versions[1].to_f
revision            = versions[2].to_i

raise "sysdig is required kernel version >= 2.6.32." unless major_minor_version > 2.6 || (major_minor_version == 2.6 && revision >= 32)

package "curl"

bash "install-sysdig" do
  user "root"
  code "curl -s https://s3.amazonaws.com/download.draios.com/stable/install-sysdig | bash"

  not_if "which sysdig"
end

unless node[:sysdig][:action].nil?
  package "sysdig" do
    action node[:sysdig][:action]
  end
end
