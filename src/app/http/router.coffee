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

server = require './server'
url = require 'url'

controller =
  error: require './controllers/error'
  home: require './controllers/home'
  public: require './controllers/public'

module.exports =
  logic: (req, res) ->
    url = url.parse req.url
    [ _, directory, type ] = url.pathname.split '/', 3
    filename = url.pathname.substring(1 + (directory||'').length + 1 + (type||'').length + 1) || ''

    directory = '/' if (!directory? || directory=='')

    switch directory
      when '/'
        controller.home.index res
      when 'contact'
        controller.home.contact res
      when 'public'
        controller.public.static type, filename, res
      else
        controller.error.http_404 res
