function nodeId = ENgetnodeid(index)
nodeId = '';
[a,nodeId]=calllib('epanet2','ENgetnodeid',index,nodeId);
if (a ~= 0)
	errstr = sprintf ('ENgetnodeid returned %d', a);
	err = MException('epanetError:ENgetnodeid', errstr);
	throw(err);
end
end

