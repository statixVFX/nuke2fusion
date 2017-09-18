--stx_merge3DConnect
--v1.0
--Creates a merge node and connects it to all the selected nodes if they are 3d
--Ignores all other selections


-- lock comp
comp:Lock()

-- get selection 
selectedNodes = comp:GetToolList(true)
flow = comp.CurrentFrame.FlowView

-- store some temp variables
tempX, tempY = 0, 0
x,y = 0, 0


-- function to return length of table
function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

-- store it in a variable
connections = tablelength(selectedNodes)

-- create merge node, and store some position variables
mg1 = comp:Merge3D()
flow = comp.CurrentFrame.FlowView
startX, startY = flow:GetPos(selectedNodes[1])

xx = 0
yy = 0 

-- loop over number of selected nodes
for i=1,connections,1 do 

	-- connect the inputs, iterate with an i on the string
	mg1:ConnectInput("SceneInput"..i, selectedNodes[i])

	
	-- update positions
	x1, y1 = flow:GetPos(selectedNodes[i])
	xx = xx + x1 - startX
	yy = yy + y1 - startY

end		

-- set final position to be in the center of all the selections
flow:SetPos(mg1, startX + (xx/connections), startY + (yy/connections))			

-- unlock
comp:Unlock()
