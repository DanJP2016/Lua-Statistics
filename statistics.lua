local statistics = {}

function statistics:mean(data)
  assert(type(data) == 'table', 'MODE function PARAMETER: DATA must be a TABLE')
  local sum = 0

  for i = 1, #data do
    sum = sum + data[i]
  end

  return sum
end

function statistics:median(data)
  assert(type(data) == 'table', 'MEDIAN function PARAMETER: DATA must be a TABLE')
  
  local sorted = {table.unpack(data)}
  table.sort(sorted)

  local m = 0

  if #sorted % 2 == 0 then
    local a = sorted[#sorted / 2]
    local b = sorted[(#sorted / 2) + 1]

    m = (a + b) / 2
  else
    m = sorted[math.ceil(#sorted / 2)]
  end

  return m
end

function statistics:range(data)
  assert(type(data) == 'table', 'RANGE function PARAMETER: DATA must be a TABLE')
  
  local sorted = {table.unpack(data)}
  table.sort(sorted)
  
  return data[#sorted] - sorted[1]
end

function statistics:variance(data, m)
  assert(type(data) == 'table', 'VARIANCE function PARAMETER: DATA must be a TABLE')

  m = m or statistics:mean(data)
  assert(type(m) == 'number', 'VARIANCE function PARAMETER: M must be a NUMBER')

  local dif = 0

  for i = 1, #data do
    dif = dif + ((data[i] - m) ^ 2)
  end

  return dif / #data
end


-- sample variance
function statistics:s_variance(data, m)
  assert(type(data) == 'table', 'S_VARIANCE function PARAMETER: DATA must be a TABLE')

  m = m or statistics:mean(data)
  assert(type(m) == 'number', 'S_VARIANCE function PARAMETER: M must be a NUMBER')

  local dif = 0

  for i = 1, #data do
    dif = dif + ((data[i] - m) ^ 2)
  end

  return dif / (#data - 1)
end

-- standard deviation
function statistics:sd(v)
  assert(type(v) == 'number', 'SD function PARAMETER: V must be a NUMBER')
  return math.sqrt(v)
end

function statistics:z_score(val, m, sd)
  assert(type(val) == 'number', 'Z_SCORE function PARAMETER: VAL must be a NUMBER')
  assert(type(m) == 'number', 'Z_SCORE function PARAMETER: M must be a NUMBER')
  assert(type(sd) == 'number', 'Z_SCORE function PARAMETER: SD must be a NUMBER')
  return (val - m) / sd
end

-- return a table with key:value pairs, option to show the output in the terminal
function statistics:z_score_all(data, m, sd, show)
  assert(type(data) == 'table', 'Z_SCORE_ALL function PARAMETER: DATA must be a TABLE')
  assert(type(m) == 'number', 'Z_SCORE_ALL function PARAMETER: M must be a NUMBER')
  assert(type(sd) == 'number', 'Z_SCORE_ALL function PARAMETER: SD must be a NUMBER')

  show = show or false
  assert(type(show) == 'boolean', 'SHOW must be a BOOLEAN value')

  local scores = {}

  for i = 1, #data do
    scores[data[i]] = (data[i] - m) / sd
  end

  if show == true then
    print('value', 'score')

    for i = 1, #data do
      print(data[i], (data[i] - m) / sd)
    end
  end

  return scores
end

return statistics
