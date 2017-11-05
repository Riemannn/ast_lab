# Copyright (C) 2017 Alexandre Pielucha
#
# Permission to use, copy, modify, and/or distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
# OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
# CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

render = require './render'
server = require './server'
url = require 'url'

module.exports =
  logic: (req, res) ->
    url = url.parse req.url
    [ _, directory, type, filename ] = url.pathname.split '/'

    directory = '/' if (!directory? || directory=='')

    switch directory
      when '/'
        render.resource 'html', 'index', res
      when 'contact'
        render.resource 'html', 'contact', res
      when 'public'
        render.resource type, filename, res
      else
        render.resource 'html', 'error_404', res
