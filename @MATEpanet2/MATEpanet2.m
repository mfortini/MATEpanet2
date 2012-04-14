classdef MATEpanet2 <handle
properties
inputFileName = '';
reportFileName = '';
binaryFileName = '';
nNodes = -1;
nLinks = -1;
end
methods
% CONSTRUCTOR %
function obj=MATEpanet2(inputFileName, reportFileName, binaryFileName)
if ~libisloaded ('epanet2')
loadlibrary epanet2 epanet2.h
end
pwd
obj.inputFileName = inputFileName;
obj.reportFileName = reportFileName;
obj.binaryFileName = binaryFileName;
try
        MATEpanet2Lib.ENopen(inputFileName,reportFileName,binaryFileName)
catch err
        if (strcmp(err.identifier, 'epanetError:ENopen'))
                MATEpanet2Lib.ENClose()
        else
                rethrow(err)
        end
end

end
%%%%%%%%%%%%%%%%%%%%%%%%%%


% DESTRUCTOR %
function delete(obj)
MATEpanet2.ENClose()
disp('destructor');
end

function  value = get.nNodes(obj)
obj.inputFileName = 'nNodes' ;
str = sprintf ('Current value %d', obj.nNodes)
if (obj.nNodes < 0) 
	nNodes = 0;
	[a,nNodes]=calllib('epanet2','ENgetcount',MATEpanet2Constants.EN_NODECOUNT,nNodes);
	obj.nNodes = nNodes;
        disp 'load';
end
value = obj.nNodes;
str = sprintf ('New value %d', obj.nNodes)
end
%%%%%%%%%%%%%%%%%%%

% NLINKS PROPERTY %
function  nLinks = getNLinks(obj)
if (obj.nLinks < 0) 
        nLinks = 0;
	[a,nLinks]=calllib('epanet2','ENgetcount',MATEpanet2Constants.EN_LINKCOUNT,nLinks);
	obj.nLinks = nLinks;
        disp 'load';
end
nLinks = obj.nLinks;
end

end

% STATIC METHODS FROM EPANET2 LIBRARY %
methods (Static)
ENinit ()
ENopen (inputFileName, reportFileName, binaryFileName)
ENclose()

ENinitH(saveflag)
t = ENrunH()
tStep = ENnextH()
ENopenH()
ENcloseH()

nNodes = ENgetnodecount()
nLinks = ENgetlinkcount()

nodeId = ENgetnodeid (index)
[nodeIds] = ENgetnodeids()
nodeIndex = ENgetnodeindex(id)
nodeType  = ENgetnodetype(index)

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% PRIVATE METHODS (WRAPPER AVAILABLE) %
methods (Static,Access=private)
count = ENgetcount(what)
value = ENgetnodevalue (index,what)
end


% NODE PROPERTIES ACCESSORS %
methods(Static)
function x = ENgetNodeElevation  (idx); x = MATEpanet2.ENgetnodevalue(idx, MATEpanet2.EN_ELEVATION  ); end
function x = ENgetNodeBaseDemand (idx); x = MATEpanet2.ENgetnodevalue(idx, MATEpanet2.EN_BASEDEMAND ); end
function x = ENgetNodePattern    (idx); x = MATEpanet2.ENgetNodeValue(idx, MATEpanet2.EN_PATTERN    ); end
function x = ENgetNodeEmitter    (idx); x = MATEpanet2.ENgetnodevalue(idx, MATEpanet2.EN_EMITTER    ); end
function x = ENgetNodeInitQual   (idx); x = MATEpanet2.ENgetnodevalue(idx, MATEpanet2.EN_INITQUAL   ); end
function x = ENgetNodeSourceQual (idx); x = MATEpanet2.ENgetnodevalue(idx, MATEpanet2.EN_SOURCEQUAL ); end
function x = ENgetNodeSourcePat  (idx); x = MATEpanet2.ENgetnodevalue(idx, MATEpanet2.EN_SOURCEPAT  ); end
function x = ENgetNodeSourceType (idx); x = MATEpanet2.ENgetnodevalue(idx, MATEpanet2.EN_SOURCETYPE ); end
function x = ENgetNodeTankLevel  (idx); x = MATEpanet2.ENgetnodevalue(idx, MATEpanet2.EN_TANKLEVEL  ); end
function x = ENgetNodeDemand     (idx); x = MATEpanet2.ENgetnodevalue(idx, MATEpanet2.EN_DEMAND     ); end
function x = ENgetNodeHead       (idx); x = MATEpanet2.ENgetnodevalue(idx, MATEpanet2.EN_HEAD       ); end
function x = ENgetNodePressure   (idx); x = MATEpanet2.ENgetnodevalue(idx, MATEpanet2.EN_PRESSURE   ); end
function x = ENgetNodeQuality    (idx); x = MATEpanet2.ENgetnodevalue(idx, MATEpanet2.EN_QUALITY    ); end
function x = ENgetNodeSourceMass (idx); x = MATEpanet2.ENgetnodevalue(idx, MATEpanet2.EN_SOURCEMASS ); end
function x = ENgetNodeInitVolume (idx); x = MATEpanet2.ENgetnodevalue(idx, MATEpanet2.EN_INITVOLUME ); end
function x = ENgetNodeMixModel   (idx); x = MATEpanet2.ENgetnodevalue(idx, MATEpanet2.EN_MIXMODEL   ); end
function x = ENgetNodeMixZoneVol (idx); x = MATEpanet2.ENgetnodevalue(idx, MATEpanet2.EN_MIXZONEVOL ); end
function x = ENgetNodeTankDiam   (idx); x = MATEpanet2.ENgetnodevalue(idx, MATEpanet2.EN_TANKDIAM   ); end
function x = ENgetNodeMinVolume  (idx); x = MATEpanet2.ENgetnodevalue(idx, MATEpanet2.EN_MINVOLUME  ); end
function x = ENgetNodeVolCurve   (idx); x = MATEpanet2.ENgetnodevalue(idx, MATEpanet2.EN_VOLCURVE   ); end
function x = ENgetNodeMinLevel   (idx); x = MATEpanet2.ENgetnodevalue(idx, MATEpanet2.EN_MINLEVEL   ); end
function x = ENgetNodeMaxLevel   (idx); x = MATEpanet2.ENgetnodevalue(idx, MATEpanet2.EN_MAXLEVEL   ); end
function x = ENgetNodeMixFraction(idx); x = MATEpanet2.ENgetnodevalue(idx, MATEpanet2.EN_MIXFRACTION); end
function x = ENgetNodeTankKBulk  (idx); x = MATEpanet2.ENgetnodevalue(idx, MATEpanet2.EN_TANK_KBULK ); end

end

properties (Constant)
EN_ELEVATION    = 0    % Node parameters
EN_BASEDEMAND   = 1
EN_PATTERN      = 2
EN_EMITTER      = 3
EN_INITQUAL     = 4
EN_SOURCEQUAL   = 5
EN_SOURCEPAT    = 6
EN_SOURCETYPE   = 7
EN_TANKLEVEL    = 8
EN_DEMAND       = 9
EN_HEAD         = 10
EN_PRESSURE     = 11
EN_QUALITY      = 12
EN_SOURCEMASS   = 13
EN_INITVOLUME   = 14
EN_MIXMODEL     = 15
EN_MIXZONEVOL   = 16

EN_TANKDIAM     = 17
EN_MINVOLUME    = 18
EN_VOLCURVE     = 19
EN_MINLEVEL     = 20
EN_MAXLEVEL     = 21
EN_MIXFRACTION  = 22
EN_TANK_KBULK   = 23

EN_DIAMETER     = 0    % Link parameters
EN_LENGTH       = 1
EN_ROUGHNESS    = 2
EN_MINORLOSS    = 3
EN_INITSTATUS   = 4
EN_INITSETTING  = 5
EN_KBULK        = 6
EN_KWALL        = 7
EN_FLOW         = 8
EN_VELOCITY     = 9
EN_HEADLOSS     = 10
EN_STATUS       = 11
EN_SETTING      = 12
EN_ENERGY       = 13

EN_DURATION     = 0    % Time parameters
EN_HYDSTEP      = 1
EN_QUALSTEP     = 2
EN_PATTERNSTEP  = 3
EN_PATTERNSTART = 4
EN_REPORTSTEP   = 5
EN_REPORTSTART  = 6
EN_RULESTEP     = 7
EN_STATISTIC    = 8
EN_PERIODS      = 9

EN_NODECOUNT    = 0    % Component counts
EN_TANKCOUNT    = 1
EN_LINKCOUNT    = 2
EN_PATCOUNT     = 3
EN_CURVECOUNT   = 4
EN_CONTROLCOUNT = 5

EN_JUNCTION     = 0    % Node types
EN_RESERVOIR    = 1
EN_TANK         = 2

EN_CVPIPE       = 0    % Link types
EN_PIPE         = 1
EN_PUMP         = 2
EN_PRV          = 3
EN_PSV          = 4
EN_PBV          = 5
EN_FCV          = 6
EN_TCV          = 7
EN_GPV          = 8

EN_NONE         = 0    % Quality analysis types
EN_CHEM         = 1
EN_AGE          = 2
EN_TRACE        = 3

EN_CONCEN       = 0    % Source quality types
EN_MASS         = 1
EN_SETPOINT     = 2
EN_FLOWPACED    = 3

EN_CFS          = 0    % Flow units types
EN_GPM          = 1
EN_MGD          = 2
EN_IMGD         = 3
EN_AFD          = 4
EN_LPS          = 5
EN_LPM          = 6
EN_MLD          = 7
EN_CMH          = 8
EN_CMD          = 9

EN_TRIALS       = 0   % Misc. options
EN_ACCURACY     = 1
EN_TOLERANCE    = 2
EN_EMITEXPON    = 3
EN_DEMANDMULT   = 4

EN_LOWLEVEL     = 0   % Control types
EN_HILEVEL      = 1
EN_TIMER        = 2
EN_TIMEOFDAY    = 3

EN_AVERAGE      = 1   % Time statistic types.
EN_MINIMUM      = 2
EN_MAXIMUM      = 3
EN_RANGE        = 4

EN_MIX1         = 0   % Tank mixing models
EN_MIX2         = 1
EN_FIFO         = 2
EN_LIFO         = 3

EN_NOSAVE       = 0   % Save-results-to-file flag
EN_SAVE         = 1
EN_INITFLOW     = 10  % Re-initialize flow flag

EN_CONST_HP     = 0   %    constant horsepower
EN_POWER_FUNC   = 1   %    power function
EN_CUSTOM       = 2   %    user-defined custom curve
EN_NOCURVE      = 3

end

end
