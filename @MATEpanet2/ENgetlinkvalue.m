function value = ENgetlinkvalue(index, what)
value = 0;
[a,value]=calllib('epanet2','ENgetlinkvalue',index,what,value);
if (a ~= 0)
	errstr = sprintf ('ENgetlinkvalue returned %d', a);
	err = MException('epanetError:ENgetlinkvalue', errstr);
	throw(err);
end
end

