function nodeType = ENgetnodetype(index)
nodeType = -1;
[a,nodeType]=calllib('epanet2','ENgetnodetype',index,nodeType);
if (a ~= 0)
	errstr = sprintf ('ENgetnodetype returned %d', a);
	err = MException('epanetError:ENgetnodetype', errstr);
	throw(err);
end
end

