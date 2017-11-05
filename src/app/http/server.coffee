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

http = require 'http'

module.exports =
  # IP Address of the server
  ip_address: '127.0.0.1'
  # Port listened by the server
  port: 8080
  # Server's logic
  logic: (req, res) ->
    res.writeHead 200,
      'Content-Type': 'text/plain'
    res.write 'Hello World!'
    res.end()



  # Set IP address & port
  setHost: (ip, po) ->
    this.ip_address = ip
    this.port = po

  # Set server's logic
  setLogic: (lo) ->
    this.logic = lo

  # Starts the server
  start: () ->
    http.createServer(this.logic).listen(this.port, this.ip_adress)

  # Returns an HTTP response containing a code and a message.
  write: (http_code, mime, message, res) ->
    res.writeHead http_code,
      'Content-Type': mime
    res.write message
    res.end()
