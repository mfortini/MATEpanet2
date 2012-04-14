function linkId = ENgetlinkid(index)
linkId = '';
[a,linkId]=calllib('epanet2','ENgetlinkid',index,linkId);
if (a ~= 0)
	errstr = sprintf ('ENgetlinkid returned %d', a);
	err = MException('epanetError:ENgetlinkid', errstr);
	throw(err);
end
end

