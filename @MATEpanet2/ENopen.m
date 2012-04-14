function ENopen (inputFileName, reportFileName, binaryFileName)
a=calllib('epanet2','ENopen',inputFileName,reportFileName,binaryFileName);
if (a ~= 0)
	errstr = sprintf ('ENopen returned %d', a);
	err = MException('epanetError:ENopen', errstr);
	throw(err);
end
end

