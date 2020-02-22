# pass-extension-open
A pass extension to open a site in the default browser

Open a site that requires authentication.

Expects a line in the password file beginning with "url:" just like the passff browser plugin.

Automatically copies the password (first line) to the clipboard.

Prints out the url and login name.

```
[user@host ~]$ pass show vimeo.com 
secret
url: https://vimeo.com
login: user.name@gmail.com
[user@host ~]$ pass open vimeo.com 
Opening site vimeo.com
Copied vimeo.com to clipboard. Will clear in 45 seconds.
url:    https://vimeo.com
login:  user.name@gmail.com
[user@host ~]$
```
