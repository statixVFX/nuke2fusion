--stx_mergeConnect
--v1.0
--Creates a merge node and connects it to the two first selections
--Ignores all other selections

-- get selected nodes
selectedNodes = comp:GetToolList(true)

--dump(selectedNodes)

-- get the current positions for the two first selections
flow = comp.CurrentFrame.FlowView
x1, y1 = flow:GetPos(selectedNodes[1])
x2, y2 = flow:GetPos(selectedNodes[2])

-- creates the merge node, connects it and sets the position to be somewhere in between the two
mg1 = comp:Merge{ Background = selectedNodes[1], Foreground = selectedNodes[2] }
flow:SetPos(mg1, x1-((x1-x2)/2) ,y1-((y1-y2)/2))

