module.exports =


	expand: (config, parameters) ->
		for name,value of config
			if typeof value is "string"
				config[name] = value.replace /(%[a-zA-Z]+%)/g, (match)=>
					match = match.replace(/%/g, '')
					return parameters[match]
			else if typeof value is "object" and !Array.isArray(value)
				@expand(config[name], parameters)
		return config


	extend: (target, source) ->
		if typeof source isnt 'object'
			return

		for key, val of source
			src = target[key]

			if typeof val isnt 'object' or val is null
				target[key] = val
				continue
			else if val instanceof Buffer
				tmpBuf = new Buffer(val.length)
				val.copy(tmpBuf)
				target[key] = tmpBuf
				continue
			else if val instanceof Date
				target[key] = new Date(val.getTime())
				continue

			if typeof src isnt 'object' or src is null
				clone = if Array.isArray(val) then [] else {}
				target[key] = @extend(clone, val)
				continue

			if Array.isArray(val)
				clone = if Array.isArray(src) then src else []
			else
				clone = if !Array.isArray(src) then src else {}

			target[key] = @extend(clone, val)
		return target