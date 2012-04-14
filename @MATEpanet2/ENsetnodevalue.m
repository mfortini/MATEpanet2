function ENsetnodevalue(index, what, value)
a=calllib('epanet2','ENsetnodevalue',index,what,value);
if (a ~= 0)
	errstr = sprintf ('ENsetnodevalue returned %d', a);
	err = MException('epanetError:ENsetnodevalue', errstr);
	throw(err);
end
end

