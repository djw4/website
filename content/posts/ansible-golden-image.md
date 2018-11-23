---
date: "2018-07-11"
title: "Ansible golden image config replacements"
---

ConfigServer Security & Firewall is a popular wrapper for iptables, especially when used in conjunction with the hosting platform cPanel. The 'firewall' itself is very feature rich and contains different abilities, some of which can be difficult to keep track of ..

```bash
[root@server ~]# wc -l /etc/csf/csf.conf
2645 /etc/csf/csf.conf
```

To this end it might make sense to keep your 'golden image' for the config file in version control in the event that settings change and need to be rolled back. Whilst this is a simple way to manage the configuration, there are certain lines in the config file that may need to be kept consistent in-between versions.

The Ansible playbook below does just that; it replaces the existing configuration file with one from a repository, but before doing so it extracts and registers some information from the outgoing config and places that in the new config.

{{< gist djw4 0804423557a869a449c44853b4b1e4c7 >}}

In this case the example is for `SMTP_ALLOWUSER` but the same workflow is very repeatable for any other playbook that needs to transfer information.