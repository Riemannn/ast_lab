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

fs = require 'fs'
pug = require 'pug'
server = require './server'
stylus = require 'stylus'

module.exports =
  # Used to render a static resource (html & css & img)
  resource: (type, filename, res) ->
    if type == 'html'
      # Render Pug
      pug.renderFile "src/templates/#{filename}.pug", {}, (err, html) ->
        throw err if err
        server.write 200, 'text/html', html, res

    else if type == 'css'
      # Render Stylus
      stylus.render fs.readFileSync("src/assets/styl/#{filename}.styl", 'utf8'), {}, (err, css) ->
        throw err if err
        server.write 200, 'text/css', css, res

    else if type == 'img'
      [ name, extension ] = filename.split '.'
      if !name? || name==''
        server.write 400, 'text/plain', 'HTTP 400: Bad request.', res
      if !extension? || (!extension in ['png', 'jpg', 'jpeg', 'gif'])
        server.write 415, 'text/plain', 'HTTP 415: Unsupported media type.', res

      # Render image
      fs.readFile "public/img/#{name}.#{extension}", (err, file) ->
        throw err if err
        extension='jpeg' if extension=='jpg'
        server.write 200, "image/#{extension}", file, res

    else if type == 'favicon.ico'
      fs.readFile 'public/favicon.ico', (err, file) ->
        throw err if err
        server.write 200, 'image/x-icon', file, res

    else
      server.write 404, 'text/plain', 'HTTP 404: file not found.', res
