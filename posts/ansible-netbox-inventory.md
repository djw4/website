---
date: "2018-11-09"
title: "Ansible inventory from Netbox"
---

We have been using the excellent [Netbox](https://github.com/digitalocean/netbox) IPAM and DCIM tool internally for tracking our networking configurations, as well as our backend infrastructure whilst also increasing the use of Ansible to remove repetetive tasks in the day-to-day. By utilising Netbox as the end-point for accessing service data, this gives us the opportunity to extrapolate the request for information from our billing and management server - siloing off our infrastructure automation behind a layer of security that was otherwise impossible.

Netbox then becomes the single pane of glass that can be polled for information at any time, using a standarised REST interface - great stuff.

The only issue for us was - how to make use of this information? We already make use of Ansible, but it's inventories have bene static up until now but thankfully [dynamic inventories](https://docs.ansible.com/ansible/2.7/user_guide/intro_dynamic_inventory.html) to the rescue.

- - - -

To cut a long story short:

* Netbox exposes a REST API that can be polled for information.
* Ansible dynamic inventories are passed through to Ansible in JSON format.

The script included below is a dynamic inventory written in Python, however unfortunately at the moment it is only compatible with Python3. A few key points for this script to run properly:

* Custom fields are being used to filter IP addresses per 'operating system' and whether or not the IP address is the 'primary' address (no an alias). For example: `"custom_fields": {"os": {"value": 3,"label": "linux-ubuntu"},"ip-type": {"value": 1,"label": "primary"}}`.
* We use the same SSH port for most servers - so this is baked into the config but easy to modify later if needed.
* The token is only necessary if your Netbox server is set up to require authentication when accessing data, normally this isn't required though (ie. public read-only).


{% gist ca3268dd1d13eeee1589f17ebc673a52 %}


Ansible will use the flag `--list`, so you can simulate this by passing in that flag and the script will output something like this:

```json
{
    'windows-server-standard': {
        'hosts': ['1.2.3.4', .. '1.2.3.7'],
        'vars': {}
    },
    'linux-ubuntu': {
        'hosts': ['1.2.3.10', .. '1.2.3.150'],
        'vars': {
            'ansible_connection': 'ssh',
            'ansible_ssh_user': 'user',
            'ansible_ssh_port': '22222'
        }
    }
}
```

