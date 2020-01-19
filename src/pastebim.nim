import
  asynchttpserver, 
  asyncdispatch, 
  rosencrantz,
  parsetoml,
  sequtils, 
  strutils, 
  strtabs,
  tables, 
  random,
  os  

# Gettin' Our Settin's from a TOML file :)
let 
  settings = parsetoml.parseFile("config.toml")
  pastedir = settings["settings"]["pastedir"].getStr()
  plugsize = settings["settings"]["plugsize"].getInt()
  plugname = settings["settings"]["plugname"].getStr()
  host = settings["server"]["host"].getStr()
  port = settings["server"]["port"].getInt()

# Must be run once before any function calls
randomize()

# generates an alpha-numeric plug if the given length
proc plug(l: int): string =
  let letters = toSeq('A' .. 'z')
  for _ in .. l:
    if result.len != l:
      let r = letters[rand(0..<letters.len)]
      if isAlphaNumeric(r) == true:
        add(result, r)

# HTTP server
let server = newAsyncHttpServer()


let handler = get[
  pathChunk("/p")[
    segment(proc(p: string): auto =
      let r = readFile(joinPath(pastedir, p))
      ok(r)
    )
  ]
] ~ 
post[
  path("/p")[
    multipart(proc(s: MultiPart): auto =
      let filename = plug(plugsize)
      if s.files.hasKey plugname:
        writeFile(joinpath(pastedir, filename), s.files[plugname].content)
        ok(host & filename)

      elif s.fields.hasKey plugname:
        writeFile(joinpath(pastedir, filename), s.fields[plugname])
        ok(host & filename)

      else:
        reject()
    )    
  ]
]

# All handlers are passed through this to catch exceptions
let handlerErrorWrapper = crashWith(Http500, ":(", logError = true)(handler)

when isMainModule:
  waitFor server.serve(Port(port), handlerErrorWrapper)