--stx_kissConnect
--v1.1
-- disabled comp locking, caused some issues

-- lock comp
-- comp:Lock()

-- get selection 
selectedNodes = comp:GetToolList(true)
allNodes = comp:GetToolList()

flow = comp.CurrentFrame.FlowView

data = {}

-- function to return length of table
function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

-- store it in a variable
connections = tablelength(selectedNodes)

-- create merge node, and store some position variables
flow = comp.CurrentFrame.FlowView
selX, selY = flow:GetPos(selectedNodes[1])


distances = {}

for i=1,tablelength(allNodes),1 do
	--print(flow:GetPos(allNodes[i]))
	tempX, tempY = flow:GetPos(allNodes[i])
	local tempDist = math.sqrt((selX-tempX)*(selX-tempX)+(selY-tempY)*(selY-tempY))
	table.insert(distances,{allNodes[i], tempDist})
	--print(tempDist)
end


table.sort(distances, function(b, a) return a[2] > b[2] end)

for k,v in ipairs(distances) do
    print(v[1], ' == ', v[2])
end


selectedNodes[1]:ConnectInput("Input", distances[2][1])
selectedNodes[1]:ConnectInput("Background", distances[2][1])
selectedNodes[1]:ConnectInput("MaterialInput", distances[2][1])
selectedNodes[1]:ConnectInput("SceneInput", distances[2][1])
selectedNodes[1]:ConnectInput("SceneInput1", distances[2][1])

--dump(allNodes)

--comp:Unlock()
