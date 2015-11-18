function sleep(n)
  os.execute("sleep " .. tonumber(n))
end

function read(f)
    local d = deferred.new()
    sleep(4)
    d:reject("fail")
    d:resolve("porno")
    return d
end

read('README.md'):next(function(data)
    print('File.txt contents: ', data)
end, function(err)
    print('Error', err)
end)

print('game')
