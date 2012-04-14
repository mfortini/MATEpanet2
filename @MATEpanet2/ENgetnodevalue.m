function value = ENgetnodevalue(index, what)
value = 0;
[a,value]=calllib('epanet2','ENgetnodevalue',index,what,value);
if (a ~= 0)
	errstr = sprintf ('ENgetnodevalue returned %d', a);
	err = MException('epanetError:ENgetnodevalue', errstr);
	throw(err);
end
end

