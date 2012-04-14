function linkType = ENgetlinktype(index)
linkType = -1;
[a,linkType]=calllib('epanet2','ENgetlinktype',index,linkType);
if (a ~= 0)
	errstr = sprintf ('ENgetlinktype returned %d', a);
	err = MException('epanetError:ENgetlinktype', errstr);
	throw(err);
end
end

