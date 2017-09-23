--stx_merge3DConnect
--v1.1
--1.0 - release
--1.1 - fixed node creation position when nothing is selected
--
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
mg1 = comp:AddTool("Merge3D", -32768, -32768)
flow = comp.CurrentFrame.FlowView
startX, startY = flow:GetPos(selectedNodes[1])

xx = 0
yy = 0 
for i=1,connections,1 do 

	-- connect the inputs, iterate with an i on the string
	mg1:ConnectInput("SceneInput"..i, selectedNodes[i])
	
	-- update positions
	x1, y1 = flow:GetPos(selectedNodes[i])
	xx = xx + x1 - startX
	yy = yy + y1 - startY
end		

-- set final position to be in the center of all the selections
if selectedNodes[1] == nil then
--	flow:SetPos(mg1, -32768, -32768)

	else	
		flow:SetPos(mg1, startX + (xx/connections), startY + (yy/connections))			

end

-- unlock
comp:Unlock()
