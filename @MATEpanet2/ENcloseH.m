function ENcloseH ()
a=calllib('epanet2','ENcloseH');
if (a ~= 0)
	errstr = sprintf ('ENcloseH returned %d', a);
	err = MException('epanetError:ENcloseH', errstr);
	throw(err);
end
end

