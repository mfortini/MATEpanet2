function count = ENgetcount(what)
count = 0;
[a,count]=calllib('epanet2','ENgetcount',what,count);
if (a ~= 0)
	errstr = sprintf ('ENgetcount returned %d', a);
	err = MException('epanetError:ENgetcount', errstr);
	throw(err);
end
end

