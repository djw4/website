#!/usr/bin/env python
# -*- coding: utf-8 -*- #
from __future__ import unicode_literals

AUTHOR = 'Daniel W'
SITENAME = 'danieljw.net'
SITEURL = ''

PATH = 'content'

TIMEZONE = 'Australia/Melbourne'

DEFAULT_LANG = 'en'

THEME = "./theme"
GOOGLE_ANALYTICS = 'UA-127724108-1'

# Feed generation is usually not desired when developing
FEED_ALL_ATOM = None
CATEGORY_FEED_ATOM = None
TRANSLATION_FEED_ATOM = None
AUTHOR_FEED_ATOM = None
AUTHOR_FEED_RSS = None

# Blogroll
# LINKS = (
#           ('Projects', 'https://github.com/djw4/'),
#         )

# Social widget
SOCIAL = (
          ('github', 'https://github.com/djw4'),
          ('linkedin', 'https://www.linkedin.com/in/djw1/'),
         )

PLUGIN_PATHS = [ './plugins', ]
PLUGINS = [
  'pelican_gist',
  'sitemap',
  'css-html-js-minify',
  'deadlinks',
  'clean_summary',
  # 'optimize_images'
]
DEADLINK_VALIDATION = True

DEFAULT_PAGINATION = False

# Uncomment following line if you want document-relative URLs when developing
#RELATIVE_URLS = True