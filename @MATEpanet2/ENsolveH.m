function ENsolveH ()
a=calllib('epanet2','ENsolveH');
if (a ~= 0)
	errstr = sprintf ('ENsolveH returned %d', a);
	err = MException('epanetError:ENsolveH', errstr);
	throw(err);
end
end

