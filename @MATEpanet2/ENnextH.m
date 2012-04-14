function tStep = ENnextH()
tStep = 0;
[a,tStep]=calllib('epanet2','ENnextH',tStep);
if (a ~= 0)
	errstr = sprintf ('ENnextH returned %d', a);
	err = MException('epanetError:ENnextH', errstr);
	throw(err);
end
ENnextH = tStep;
end

