#!/bin/bash

# File: examples/bin/preinstall - convenience script to add nomad
# VM node host information to /etc/hosts for Vagrant

nomad1="10\.1\.42\.70"

# Log stuff
function logmsg {
    msgtype="$1"
    msgtxt="$2"
    case "${msgtype}" in
        greeting)
            printf "🌞  ${txtylw}${msgtxt}\n"
            ;;
        info)
            printf "💬  ${txtwht}${msgtxt}\n"
            ;;
        success)
            printf "✅  ${txtgrn}${msgtxt}\n"
            ;;
        notice)
            printf "🚩  ${txtylw}${msgtxt}\n"
            ;;
        alert)
            printf "⛔️  ${txtred}${msgtxt}\n" >&2
            ;;
        *)
            printf "⁉️  ${txtwht}${msgtxt}\n" >&2
            ;;
    esac
}

# Check if sudo will need password
function sudocheck {
  logmsg info "Enter your user account password for sudo if prompted"
  sudo true
}

# Add hosts entries if necessary
function add_hosts {
  if grep nomad1 /etc/hosts > /dev/null 2>&1; then
    logmsg success "nomad VM node information present in /etc/hosts"
  else
    sudocheck
    sudo sh -c "echo '# Nomad Vagrant virtual machine hosts
10.1.42.70 nomad1.local nomad1
10.1.42.71 nomad2.local nomad2
10.1.42.72 nomad3.local nomad3
' >> /etc/hosts"
    logmsg success "Nomad node host information added to /etc/hosts"
  fi
}

# Install Vagrant Hosts plugin if necessary
function vagrant_hosts_plugin {
  if vagrant plugin list | grep vagrant-hosts > /dev/null 2>&1; then
    logmsg success "Vagrant Hosts plugin is installed"
  else
    vagrant plugin install vagrant-hosts > /dev/null 2>&1
    logmsg success "Installed Vagrant Hosts plugin"
  fi
}

add_hosts
vagrant_hosts_plugin

