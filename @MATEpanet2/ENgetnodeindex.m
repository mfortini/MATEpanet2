function nodeIndex = ENgetnodeindex(id)
nodeIndex = 0;
[a,id,nodeIndex]=calllib('epanet2','ENgetnodeindex',id,nodeIndex);
if (a ~= 0)
	errstr = sprintf ('ENgetnodeindex returned %d', a);
	err = MException('epanetError:ENgetnodeindex', errstr);
	throw(err);
end
end

