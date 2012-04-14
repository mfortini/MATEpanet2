function linkIndex = ENgetlinkindex(id)
linkIndex = 0;
[a,id,linkIndex]=calllib('epanet2','ENgetlinkindex',id,linkIndex);
if (a ~= 0)
	errstr = sprintf ('ENgetlinkindex returned %d', a);
	err = MException('epanetError:ENgetlinkindex', errstr);
	throw(err);
end
end

