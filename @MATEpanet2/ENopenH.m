function ENopenH ()
a=calllib('epanet2','ENopenH');
if (a ~= 0)
	errstr = sprintf ('ENopenH returned %d', a);
	err = MException('epanetError:ENopenH', errstr);
	throw(err);
end
end

