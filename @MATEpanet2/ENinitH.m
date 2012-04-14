function ENinitH(saveflag)
a=calllib('epanet2','ENinitH',saveflag);
if (a ~= 0)
	errstr = sprintf ('ENinitH returned %d', a);
	err = MException('epanetError:ENinitH', errstr);
	throw(err);
end
end

