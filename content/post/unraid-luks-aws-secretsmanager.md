---
date: "2019-01-27"
title: "Automatically decrypt Unraid LUKS with AWS Secrets Manager"
draft: false
---

One function of unraid that I really enjoy is the ability to configure individual drives in the array with full disk encryption. This encrpytion method is always recommended if you are storing files long term that you wouldn't want the general public to have access to.

If you were to be robbed, and your server stolen - unless you had full disk encryption in place the files on that server would be accessible to anyone. With the disk encrpytion in place, everything operates as normal, except for the fact that you need to enter your decryption password in the web-interface when the server has booted up. Whilst this is a minor inconvenience, it's one that is easily worked around with a little bit of effort.

I have set up my Unraid server to automatically pull down the decryption key, from the Amazon Web Services (AWS) product called 'Secrets Manager'. This product traditionally is used for storing credentials within the AWS ecosystem, however using the aws cli it can be used to store plaintext values such as the decryption key for use in other applications.

Setting this up is very easy, and only takes about 10 minutes to complete. The monthly cost for storing 1 secret is currently $0.40AUD which makes this a very economical solution long term.

> By using this method; if your Unraid server is removed from it's current location and started up elsewhere (assuming that you chose to restrict the IAM user IP) - the array will fail to decrypt as the IP address the AWS CLI request is originating from will be different to the allowed value. Only returning the server, updating the AWS IAM policy, or providing the key will allow the array to boot.

Inspiration for this process was the great tutorial available by Spaceinvader One on [YouTube](https://www.youtube.com/watch?v=TSlHEBR1yfY) and I'd highly recommend watching some of his other videos as well.

#### AWS Console

1. The first step is to ensure that you have the array decryption key recorded correctly - this is a 'no-brainer' as otherwise your server will be inaccessible.
2. Create an AWS account, if you don't already have one (hint: you can use this same account for offsite-backups as well!) and log into the console.
3. From the console, use the search box to find 'Secrets Manager. Click on 'Store a new secret', and then use the  wizard to create your key - remember to take note of the key/value pair when creating the key and also to ensure there are no typos. Use the screenshots below to guide you if needed.
![aws630](/img/unraid-luks-aws630.jpg)
![aws712](/img/unraid-luks-aws712.jpg)
![aws740](/img/unraid-luks-aws740.jpg)
![aws753](/img/unraid-luks-aws753.jpg)

4. Click on your newly created secret, and make a note of the 'ARN' (Amazon Resource Number) - this is the full identifier to this resource and we will need it later. 
5. Next use the search again to find the 'IAM' module, then click 'Users -> Add user'.
6. Give your user a name (not really important, but name it appropriately), and tick 'Programmatic access' then click next.
![aws708](/img/unraid-luks-aws708.jpg)

7. Click on 'Attach existing policies directly' then 'Create policy' and a new window will open. In this new window choose the following options then click 'Review policy', give the policy a name and click 'Create policy':
   * Service: Secrets Manager
   * Actions: READ
   * Resources: 'Specific' -> 'Add ARN to restrict access' (then paste in your recorded ARN)
   * Request conditions: 'Source IP' (add your public IP address)
   ![aws7122](/img/unraid-luks-aws7122.jpg)


8. With the IAM policy created, close the window and refresh the 'Add user' wizard, and select your new policy.
9. Add tags if you need, otherwise click 'Next: Review' and then 'Create user'. Record the 'Access Key ID' and 'Secret Key' for use shortly.

#### Unraid Web GUI

1. From the Unraid web GUI, click on 'Plugins' then 'Nerd Tools'. If you don't have Nerd Tools already, you can install it from the community applications module. If you don't have that either, there are plenty of guides to help you install that first.
![aws715](/img/unraid-luks-aws715.jpg)


2. Use the search box on the Nerd Tools page to find `python3` and `jq-onig`, flick both to 'On' and click apply.

#### Unraid console (SSH)

1. With all those other steps completed, log into your server via SSH as the root user.
2. We chose Python3 because the default Python verison installed on Unraid (2.7) does not have Pip installed, and we need it to then install the aws cli.
3. To install the AWS cli use [this command](https://docs.aws.amazon.com/cli/latest/userguide/install-linux.html): `pip3 install awscli --upgrade --user`. This package will be installed to `/root/.local/bin/aws` because we specified the `--user` flag. This directory also isn't included in our `$PATH` by default, but for this use-case it's not necessary to fix that.
4. Configure your AWS cli using this command: `/root/.local/bin/aws configure` and follow the prompts, providing your AWS credentials from earlier.
5. Finally, test that you can retrieve your secret key using this formula: 

```
/root/.local/bin/aws secretsmanager get-secret-value --secret-id <<YOUR-ARN-HERE>> --query SecretString | jq -r ".key"
```

If all went well, then the decryption key that you recorded in the secrets manager will be output to the screen - hurray!

The last step is to edit your servers 'go' file, which is executed upon startup - use whichever method you wish (via SSH and nano/vim or over the network) and add the following:

```
/root/.local/bin/aws secretsmanager get-secret-value --secret-id <<YOUR-ARN-HERE>> --query SecretString | jq -r ".key" >> /root/keyfile
```

Substitute `<<YOUR-ARN-HERE>>` with your real ARN (ie. arn:aws:secretsmanager:ap-southeast-2:61...:secret:unraid-keyfile...) and save the file. The contents of this file will be executed when your server next starts up, and the decryption key will be downloaded automatically - then output as the keyfile.

When that process finishes executing, your server's array should start up. If you ever want to remove this functionality simple comment or remove the line in the go file. 

