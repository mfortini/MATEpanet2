function ENsetlinkvalue(index, what, value)
a=calllib('epanet2','ENsetlinkvalue',index,what,value);
if (a ~= 0)
	errstr = sprintf ('ENsetlinkvalue returned %d', a);
	err = MException('epanetError:ENsetlinkvalue', errstr);
	throw(err);
end
end

