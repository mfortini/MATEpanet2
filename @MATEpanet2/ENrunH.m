function t = ENrunH()
t = 0;
[a,t]=calllib('epanet2','ENrunH',t);
if (a ~= 0)
	errstr = sprintf ('ENrunH returned %d', a);
	err = MException('epanetError:ENrunH', errstr);
	throw(err);
end
ENrunH = t;
end

