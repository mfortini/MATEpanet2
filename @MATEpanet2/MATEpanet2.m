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

ENsolveH()
ENopenH()
ENinitH(saveflag)
t = ENrunH()
tStep = ENnextH()
ENcloseH()

nNodes = ENgetnodecount()
nLinks = ENgetlinkcount()

nodeId = ENgetnodeid (index)
function x = ENgetnodeids(); x = []; for i=1:MATEpanet2.ENgetnodecount(); x{i}=MATEpanet2.ENgetnodeid(i);end;end
nodeIndex = ENgetnodeindex(id)
nodeType  = ENgetnodetype(index)
function x = ENgetnodetypes(); x = []; for i=1:MATEpanet2.ENgetnodecount(); x(i)=MATEpanet2.ENgetnodetype(i);end;end

linkId = ENgetlinkid (index)
function x = ENgetlinkids(); x = []; for i=1:MATEpanet2.ENgetlinkcount(); x{i}=MATEpanet2.ENgetlinkid(i);end;end
linkIndex = ENgetlinkindex(id)
linkType  = ENgetlinktype(index)
function x = ENgetlinktypes(); x = []; for i=1:MATEpanet2.ENgetlinkcount(); x(i)=MATEpanet2.ENgetlinktype(i);end;end
nodes = ENgetlinknodes(index)
function x = ENgetlinksnodes(); n = MATEpanet2.ENgetlinkcount(); x = zeros(n,2); for i=1:n; x(i,:)=MATEpanet2.ENgetlinknodes(i);end;end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% PRIVATE METHODS (WRAPPER AVAILABLE) %
methods (Static,Access=private)
count = ENgetcount(what)

value = ENgetnodevalue (index,what)
value = ENgetlinkvalue (index,what)

ENsetnodevalue (index,what,value)
ENsetlinkvalue (index,what,value)
end

% LINK PROPERTIES GETTERS %
methods(Static)
function x = ENgetLinkDiameter    (idx); x = MATEpanet2.ENgetlinkvalue(idx, MATEpanet2.EN_DIAMETER   ); end
function x = ENgetLinkLength      (idx); x = MATEpanet2.ENgetlinkvalue(idx, MATEpanet2.EN_LENGTH     ); end
function x = ENgetLinkRoughness   (idx); x = MATEpanet2.ENgetlinkvalue(idx, MATEpanet2.EN_ROUGHNESS  ); end
function x = ENgetLinkMinorLoss   (idx); x = MATEpanet2.ENgetlinkvalue(idx, MATEpanet2.EN_MINORLOSS  ); end
function x = ENgetLinkInitStatus  (idx); x = MATEpanet2.ENgetlinkvalue(idx, MATEpanet2.EN_INITSTATUS ); end
function x = ENgetLinkInitSetting (idx); x = MATEpanet2.ENgetlinkvalue(idx, MATEpanet2.EN_INITSETTING); end
function x = ENgetLinkKBulk       (idx); x = MATEpanet2.ENgetlinkvalue(idx, MATEpanet2.EN_KBULK      ); end
function x = ENgetLinkKWall       (idx); x = MATEpanet2.ENgetlinkvalue(idx, MATEpanet2.EN_KWALL      ); end
function x = ENgetLinkFlow        (idx); x = MATEpanet2.ENgetlinkvalue(idx, MATEpanet2.EN_FLOW       ); end
function x = ENgetLinkVelocity    (idx); x = MATEpanet2.ENgetlinkvalue(idx, MATEpanet2.EN_VELOCITY   ); end
function x = ENgetLinkHeadLoss    (idx); x = MATEpanet2.ENgetlinkvalue(idx, MATEpanet2.EN_HEADLOSS   ); end
function x = ENgetLinkStatus      (idx); x = MATEpanet2.ENgetlinkvalue(idx, MATEpanet2.EN_STATUS     ); end
function x = ENgetLinkSetting     (idx); x = MATEpanet2.ENgetlinkvalue(idx, MATEpanet2.EN_SETTING    ); end
function x = ENgetLinkEnergy      (idx); x = MATEpanet2.ENgetlinkvalue(idx, MATEpanet2.EN_ENERGY     ); end
end

% LINK PROPERTIES ARRAY GETTERS %
methods(Static)
function x = ENgetLinkDiameters    (); x = []; for i=1:MATEpanet2.ENgetlinkcount(); x(i)=MATEpanet2.ENgetLinkDiameter   (i);end;end
function x = ENgetLinkLengths      (); x = []; for i=1:MATEpanet2.ENgetlinkcount(); x(i)=MATEpanet2.ENgetLinkLength     (i);end;end
function x = ENgetLinkRoughnesses  (); x = []; for i=1:MATEpanet2.ENgetlinkcount(); x(i)=MATEpanet2.ENgetLinkRoughness  (i);end;end
function x = ENgetLinkMinorLosses  (); x = []; for i=1:MATEpanet2.ENgetlinkcount(); x(i)=MATEpanet2.ENgetLinkMinorLoss  (i);end;end
function x = ENgetLinkInitStatuses (); x = []; for i=1:MATEpanet2.ENgetlinkcount(); x(i)=MATEpanet2.ENgetLinkInitStatus (i);end;end
function x = ENgetLinkInitSettings (); x = []; for i=1:MATEpanet2.ENgetlinkcount(); x(i)=MATEpanet2.ENgetLinkInitSetting(i);end;end
function x = ENgetLinkKBulks       (); x = []; for i=1:MATEpanet2.ENgetlinkcount(); x(i)=MATEpanet2.ENgetLinkKBulk      (i);end;end
function x = ENgetLinkKWalls       (); x = []; for i=1:MATEpanet2.ENgetlinkcount(); x(i)=MATEpanet2.ENgetLinkKWall      (i);end;end

function x = ENgetLinkFlows     (); x = []; for i=1:MATEpanet2.ENgetlinkcount(); x(i)=MATEpanet2.ENgetLinkFlow    (i);end;end
function x = ENgetLinkVelocities(); x = []; for i=1:MATEpanet2.ENgetlinkcount(); x(i)=MATEpanet2.ENgetLinkVelocity(i);end;end
function x = ENgetLinkHeadLosses(); x = []; for i=1:MATEpanet2.ENgetlinkcount(); x(i)=MATEpanet2.ENgetLinkHeadLoss(i);end;end
function x = ENgetLinkStatuses  (); x = []; for i=1:MATEpanet2.ENgetlinkcount(); x(i)=MATEpanet2.ENgetLinkStatus  (i);end;end
function x = ENgetLinkSettings  (); x = []; for i=1:MATEpanet2.ENgetlinkcount(); x(i)=MATEpanet2.ENgetLinkSetting (i);end;end
function x = ENgetLinkEnergies  (); x = []; for i=1:MATEpanet2.ENgetlinkcount(); x(i)=MATEpanet2.ENgetLinkEnergt  (i);end;end
end

% LINK PROPERTIES SETTERS %
methods(Static)
function ENsetLinkDiameter    (idx, value); MATEpanet2.ENsetlinkvalue(idx, MATEpanet2.EN_DIAMETER   , value); end
function ENsetLinkLength      (idx, value); MATEpanet2.ENsetlinkvalue(idx, MATEpanet2.EN_LENGTH     , value); end
function ENsetLinkRoughness   (idx, value); MATEpanet2.ENsetlinkvalue(idx, MATEpanet2.EN_ROUGHNESS  , value); end
function ENsetLinkMinorLoss   (idx, value); MATEpanet2.ENsetlinkvalue(idx, MATEpanet2.EN_MINORLOSS  , value); end
function ENsetLinkInitStatus  (idx, value); MATEpanet2.ENsetlinkvalue(idx, MATEpanet2.EN_INITSTATUS , value); end
function ENsetLinkInitSetting (idx, value); MATEpanet2.ENsetlinkvalue(idx, MATEpanet2.EN_INITSETTING, value); end
function ENsetLinkKBulk       (idx, value); MATEpanet2.ENsetlinkvalue(idx, MATEpanet2.EN_KBULK      , value); end
function ENsetLinkKWall       (idx, value); MATEpanet2.ENsetlinkvalue(idx, MATEpanet2.EN_KWALL      , value); end
function ENsetLinkFlow        (idx, value); MATEpanet2.ENsetlinkvalue(idx, MATEpanet2.EN_FLOW       , value); end
function ENsetLinkVelocity    (idx, value); MATEpanet2.ENsetlinkvalue(idx, MATEpanet2.EN_VELOCITY   , value); end
function ENsetLinkHeadLoss    (idx, value); MATEpanet2.ENsetlinkvalue(idx, MATEpanet2.EN_HEADLOSS   , value); end
function ENsetLinkStatus      (idx, value); MATEpanet2.ENsetlinkvalue(idx, MATEpanet2.EN_STATUS     , value); end
function ENsetLinkSetting     (idx, value); MATEpanet2.ENsetlinkvalue(idx, MATEpanet2.EN_SETTING    , value); end
function ENsetLinkEnergy      (idx, value); MATEpanet2.ENsetlinkvalue(idx, MATEpanet2.EN_ENERGY     , value); end
end

% LINK PROPERTIES ARRAY SETTERS %
methods(Static)
function ENsetLinkDiameters    (values); for i=1:MATEpanet2.ENgetlinkcount(); MATEpanet2.ENsetLinkDiameter   (i, values(i));end;end
function ENsetLinkLengths      (values); for i=1:MATEpanet2.ENgetlinkcount(); MATEpanet2.ENsetLinkLength     (i, values(i));end;end
function ENsetLinkRoughnesses  (values); for i=1:MATEpanet2.ENgetlinkcount(); MATEpanet2.ENsetLinkRoughness  (i, values(i));end;end
function ENsetLinkMinorLosses  (values); for i=1:MATEpanet2.ENgetlinkcount(); MATEpanet2.ENsetLinkMinorLoss  (i, values(i));end;end
function ENsetLinkInitStatuses (values); for i=1:MATEpanet2.ENgetlinkcount(); MATEpanet2.ENsetLinkInitStatus (i, values(i));end;end
function ENsetLinkInitSettings (values); for i=1:MATEpanet2.ENgetlinkcount(); MATEpanet2.ENsetLinkInitSetting(i, values(i));end;end
function ENsetLinkKBulks       (values); for i=1:MATEpanet2.ENgetlinkcount(); MATEpanet2.ENsetLinkKBulk      (i, values(i));end;end
function ENsetLinkKWalls       (values); for i=1:MATEpanet2.ENgetlinkcount(); MATEpanet2.ENsetLinkKWall      (i, values(i));end;end

function ENsetLinkFlows     (values); for i=1:MATEpanet2.ENgetlinkcount(); MATEpanet2.ENsetLinkFlow    (i, values(i));end;end
function ENsetLinkVelocities(values); for i=1:MATEpanet2.ENgetlinkcount(); MATEpanet2.ENsetLinkVelocity(i, values(i));end;end
function ENsetLinkHeadLosses(values); for i=1:MATEpanet2.ENgetlinkcount(); MATEpanet2.ENsetLinkHeadLoss(i, values(i));end;end
function ENsetLinkStatuses  (values); for i=1:MATEpanet2.ENgetlinkcount(); MATEpanet2.ENsetLinkStatus  (i, values(i));end;end
function ENsetLinkSettings  (values); for i=1:MATEpanet2.ENgetlinkcount(); MATEpanet2.ENsetLinkSetting (i, values(i));end;end
function ENsetLinkEnergies  (values); for i=1:MATEpanet2.ENgetlinkcount(); MATEpanet2.ENsetLinkEnergt  (i, values(i));end;end
end

% NODE PROPERTIES GETTERS %
methods(Static)
% (parameter values) %
function x = ENgetNodeElevation  (idx); x = MATEpanet2.ENgetnodevalue(idx, MATEpanet2.EN_ELEVATION  ); end
function x = ENgetNodeBaseDemand (idx); x = MATEpanet2.ENgetnodevalue(idx, MATEpanet2.EN_BASEDEMAND ); end
function x = ENgetNodePattern    (idx); x = MATEpanet2.ENgetNodeValue(idx, MATEpanet2.EN_PATTERN    ); end
function x = ENgetNodeEmitter    (idx); x = MATEpanet2.ENgetnodevalue(idx, MATEpanet2.EN_EMITTER    ); end
function x = ENgetNodeInitQual   (idx); x = MATEpanet2.ENgetnodevalue(idx, MATEpanet2.EN_INITQUAL   ); end
function x = ENgetNodeSourceQual (idx); x = MATEpanet2.ENgetnodevalue(idx, MATEpanet2.EN_SOURCEQUAL ); end
function x = ENgetNodeSourcePat  (idx); x = MATEpanet2.ENgetnodevalue(idx, MATEpanet2.EN_SOURCEPAT  ); end
function x = ENgetNodeSourceType (idx); x = MATEpanet2.ENgetnodevalue(idx, MATEpanet2.EN_SOURCETYPE ); end
function x = ENgetNodeTankLevel  (idx); x = MATEpanet2.ENgetnodevalue(idx, MATEpanet2.EN_TANKLEVEL  ); end

% (calculated values) %
function x = ENgetNodeDemand     (idx); x = MATEpanet2.ENgetnodevalue(idx, MATEpanet2.EN_DEMAND     ); end
function x = ENgetNodeHead       (idx); x = MATEpanet2.ENgetnodevalue(idx, MATEpanet2.EN_HEAD       ); end
function x = ENgetNodePressure   (idx); x = MATEpanet2.ENgetnodevalue(idx, MATEpanet2.EN_PRESSURE   ); end
function x = ENgetNodeQuality    (idx); x = MATEpanet2.ENgetnodevalue(idx, MATEpanet2.EN_QUALITY    ); end
function x = ENgetNodeSourceMass (idx); x = MATEpanet2.ENgetnodevalue(idx, MATEpanet2.EN_SOURCEMASS ); end

% (parameter values only for tank nodes) %
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

% NODE PROPERTIES ARRAY GETTERS %
methods(Static)
% (arrays of parameters) %
function x = ENgetNodeElevations  (); x = []; for i=1:MATEpanet2.ENgetnodecount(); x(i)=MATEpanet2.ENgetNodeElevation (i);end;end
function x = ENgetNodeBaseDemands (); x = []; for i=1:MATEpanet2.ENgetnodecount(); x(i)=MATEpanet2.ENgetNodeBaseDemand(i);end;end
function x = ENgetNodePatterns    (); x = []; for i=1:MATEpanet2.ENgetnodecount(); x(i)=MATEpanet2.ENgetNodePattern   (i);end;end
function x = ENgetNodeEmitters    (); x = []; for i=1:MATEpanet2.ENgetnodecount(); x(i)=MATEpanet2.ENgetNodeEmitter   (i);end;end
function x = ENgetNodeInitQuals   (); x = []; for i=1:MATEpanet2.ENgetnodecount(); x(i)=MATEpanet2.ENgetNodeInitQual  (i);end;end
function x = ENgetNodeSourceQuals (); x = []; for i=1:MATEpanet2.ENgetnodecount(); x(i)=MATEpanet2.ENgetNodeSourceQual(i);end;end
function x = ENgetNodeSourcePats  (); x = []; for i=1:MATEpanet2.ENgetnodecount(); x(i)=MATEpanet2.ENgetNodeSourcePat (i);end;end
function x = ENgetNodeSourceTypes (); x = []; for i=1:MATEpanet2.ENgetnodecount(); x(i)=MATEpanet2.ENgetNodeSourceType(i);end;end
function x = ENgetNodeTankLevels  (); x = []; for i=1:MATEpanet2.ENgetnodecount(); x(i)=MATEpanet2.ENgetNodeTankLevel (i);end;end

% (arrays of all calculated values) %
function x = ENgetNodeDemands     (); x = []; for i=1:MATEpanet2.ENgetnodecount(); x(i)=MATEpanet2.ENgetNodeDemand    (i);end;end
function x = ENgetNodeHeads       (); x = []; for i=1:MATEpanet2.ENgetnodecount(); x(i)=MATEpanet2.ENgetNodeHead      (i);end;end
function x = ENgetNodePressures   (); x = []; for i=1:MATEpanet2.ENgetnodecount(); x(i)=MATEpanet2.ENgetNodePressure  (i);end;end
function x = ENgetNodeQualities   (); x = []; for i=1:MATEpanet2.ENgetnodecount(); x(i)=MATEpanet2.ENgetNodeQuality   (i);end;end
function x = ENgetNodeSourceMasses(); x = []; for i=1:MATEpanet2.ENgetnodecount(); x(i)=MATEpanet2.ENgetNodeSourceMass(i);end;end

function x = ENgetNodeInitVolumes (); x = []; for i=1:MATEpanet2.ENgetnodecount(); try; x(i)=MATEpanet2.ENgetNodeInitVolume (i); catch x(i)=NaN;end;end;end
function x = ENgetNodeMixModels   (); x = []; for i=1:MATEpanet2.ENgetnodecount(); try; x(i)=MATEpanet2.ENgetNodeMixModel   (i); catch x(i)=NaN;end;end;end
function x = ENgetNodeMixZoneVols (); x = []; for i=1:MATEpanet2.ENgetnodecount(); try; x(i)=MATEpanet2.ENgetNodeMixZoneVol (i); catch x(i)=NaN;end;end;end
function x = ENgetNodeTankDiams   (); x = []; for i=1:MATEpanet2.ENgetnodecount(); try; x(i)=MATEpanet2.ENgetNodeTankDiam   (i); catch x(i)=NaN;end;end;end
function x = ENgetNodeMinVolumes  (); x = []; for i=1:MATEpanet2.ENgetnodecount(); try; x(i)=MATEpanet2.ENgetNodeMinVolume  (i); catch x(i)=NaN;end;end;end
function x = ENgetNodeVolCurves   (); x = []; for i=1:MATEpanet2.ENgetnodecount(); try; x(i)=MATEpanet2.ENgetNodeVolCurve   (i); catch x(i)=NaN;end;end;end
function x = ENgetNodeMinLevels   (); x = []; for i=1:MATEpanet2.ENgetnodecount(); try; x(i)=MATEpanet2.ENgetNodeMinLevel   (i); catch x(i)=NaN;end;end;end
function x = ENgetNodeMaxLevels   (); x = []; for i=1:MATEpanet2.ENgetnodecount(); try; x(i)=MATEpanet2.ENgetNodeMaxLevel   (i); catch x(i)=NaN;end;end;end
function x = ENgetNodeMixFractions(); x = []; for i=1:MATEpanet2.ENgetnodecount(); try; x(i)=MATEpanet2.ENgetNodeMixFraction(i); catch x(i)=NaN;end;end;end
function x = ENgetNodeTankKBulks  (); x = []; for i=1:MATEpanet2.ENgetnodecount(); try; x(i)=MATEpanet2.ENgetNodeTankKBulk  (i); catch x(i)=NaN;end;end;end
end

% NODE PROPERTIES SETTERS %
methods(Static)
% (parameter values) %
function ENsetNodeElevation  (idx, value); MATEpanet2.ENsetnodevalue(idx, MATEpanet2.EN_ELEVATION , value); end
function ENsetNodeBaseDemand (idx, value); MATEpanet2.ENsetnodevalue(idx, MATEpanet2.EN_BASEDEMAND, value); end
function ENsetNodePattern    (idx, value); MATEpanet2.ENsetNodeValue(idx, MATEpanet2.EN_PATTERN   , value); end
function ENsetNodeEmitter    (idx, value); MATEpanet2.ENsetnodevalue(idx, MATEpanet2.EN_EMITTER   , value); end
function ENsetNodeInitQual   (idx, value); MATEpanet2.ENsetnodevalue(idx, MATEpanet2.EN_INITQUAL  , value); end
function ENsetNodeSourceQual (idx, value); MATEpanet2.ENsetnodevalue(idx, MATEpanet2.EN_SOURCEQUAL, value); end
function ENsetNodeSourcePat  (idx, value); MATEpanet2.ENsetnodevalue(idx, MATEpanet2.EN_SOURCEPAT , value); end
function ENsetNodeSourceType (idx, value); MATEpanet2.ENsetnodevalue(idx, MATEpanet2.EN_SOURCETYPE, value); end
function ENsetNodeTankLevel  (idx, value); MATEpanet2.ENsetnodevalue(idx, MATEpanet2.EN_TANKLEVEL , value); end

% (parameter values only for tank nodes) %
function ENsetNodeInitVolume (idx, value); MATEpanet2.ENsetnodevalue(idx, MATEpanet2.EN_INITVOLUME , value); end
function ENsetNodeMixModel   (idx, value); MATEpanet2.ENsetnodevalue(idx, MATEpanet2.EN_MIXMODEL   , value); end
function ENsetNodeMixZoneVol (idx, value); MATEpanet2.ENsetnodevalue(idx, MATEpanet2.EN_MIXZONEVOL , value); end
function ENsetNodeTankDiam   (idx, value); MATEpanet2.ENsetnodevalue(idx, MATEpanet2.EN_TANKDIAM   , value); end
function ENsetNodeMinVolume  (idx, value); MATEpanet2.ENsetnodevalue(idx, MATEpanet2.EN_MINVOLUME  , value); end
function ENsetNodeVolCurve   (idx, value); MATEpanet2.ENsetnodevalue(idx, MATEpanet2.EN_VOLCURVE   , value); end
function ENsetNodeMinLevel   (idx, value); MATEpanet2.ENsetnodevalue(idx, MATEpanet2.EN_MINLEVEL   , value); end
function ENsetNodeMaxLevel   (idx, value); MATEpanet2.ENsetnodevalue(idx, MATEpanet2.EN_MAXLEVEL   , value); end
function ENsetNodeMixFraction(idx, value); MATEpanet2.ENsetnodevalue(idx, MATEpanet2.EN_MIXFRACTION, value); end
function ENsetNodeTankKBulk  (idx, value); MATEpanet2.ENsetnodevalue(idx, MATEpanet2.EN_TANK_KBULK , value); end
end

% NODE PROPERTIES ARRAY SETTERS %
methods(Static)
function ENsetNodeElevations  (values); for i=1:MATEpanet2.ENgetnodecount(); MATEpanet2.ENsetNodeElevation (i, values(i));end;end
function ENsetNodeBaseDemands (values); for i=1:MATEpanet2.ENgetnodecount(); MATEpanet2.ENsetNodeBaseDemand(i, values(i));end;end
function ENsetNodePatterns    (values); for i=1:MATEpanet2.ENgetnodecount(); MATEpanet2.ENsetNodePattern   (i, values(i));end;end
function ENsetNodeEmitters    (values); for i=1:MATEpanet2.ENgetnodecount(); MATEpanet2.ENsetNodeEmitter   (i, values(i));end;end
function ENsetNodeInitQuals   (values); for i=1:MATEpanet2.ENgetnodecount(); MATEpanet2.ENsetNodeInitQual  (i, values(i));end;end
function ENsetNodeSourceQuals (values); for i=1:MATEpanet2.ENgetnodecount(); MATEpanet2.ENsetNodeSourceQual(i, values(i));end;end
function ENsetNodeSourcePats  (values); for i=1:MATEpanet2.ENgetnodecount(); MATEpanet2.ENsetNodeSourcePat (i, values(i));end;end
function ENsetNodeSourceTypes (values); for i=1:MATEpanet2.ENgetnodecount(); MATEpanet2.ENsetNodeSourceType(i, values(i));end;end
function ENsetNodeTankLevels  (values); for i=1:MATEpanet2.ENgetnodecount(); MATEpanet2.ENsetNodeTankLevel (i, values(i));end;end

% (arrays of all calculated values) %
function ENsetNodeDemands     (values); for i=1:MATEpanet2.ENgetnodecount(); MATEpanet2.ENsetNodeDemand    (i, values(i));end;end
function ENsetNodeHeads       (values); for i=1:MATEpanet2.ENgetnodecount(); MATEpanet2.ENsetNodeHead      (i, values(i));end;end
function ENsetNodePressures   (values); for i=1:MATEpanet2.ENgetnodecount(); MATEpanet2.ENsetNodePressure  (i, values(i));end;end
function ENsetNodeQualities   (values); for i=1:MATEpanet2.ENgetnodecount(); MATEpanet2.ENsetNodeQuality   (i, values(i));end;end
function ENsetNodeSourceMasses(values); for i=1:MATEpanet2.ENgetnodecount(); MATEpanet2.ENsetNodeSourceMass(i, values(i));end;end

function ENsetNodeInitVolumes (values); for i=1:MATEpanet2.ENgetnodecount(); try; MATEpanet2.ENsetNodeInitVolume (i, values(i)); catch ;end;end;end
function ENsetNodeMixModels   (values); for i=1:MATEpanet2.ENgetnodecount(); try; MATEpanet2.ENsetNodeMixModel   (i, values(i)); catch ;end;end;end
function ENsetNodeMixZoneVols (values); for i=1:MATEpanet2.ENgetnodecount(); try; MATEpanet2.ENsetNodeMixZoneVol (i, values(i)); catch ;end;end;end
function ENsetNodeTankDiams   (values); for i=1:MATEpanet2.ENgetnodecount(); try; MATEpanet2.ENsetNodeTankDiam   (i, values(i)); catch ;end;end;end
function ENsetNodeMinVolumes  (values); for i=1:MATEpanet2.ENgetnodecount(); try; MATEpanet2.ENsetNodeMinVolume  (i, values(i)); catch ;end;end;end
function ENsetNodeVolCurves   (values); for i=1:MATEpanet2.ENgetnodecount(); try; MATEpanet2.ENsetNodeVolCurve   (i, values(i)); catch ;end;end;end
function ENsetNodeMinLevels   (values); for i=1:MATEpanet2.ENgetnodecount(); try; MATEpanet2.ENsetNodeMinLevel   (i, values(i)); catch ;end;end;end
function ENsetNodeMaxLevels   (values); for i=1:MATEpanet2.ENgetnodecount(); try; MATEpanet2.ENsetNodeMaxLevel   (i, values(i)); catch ;end;end;end
function ENsetNodeMixFractions(values); for i=1:MATEpanet2.ENgetnodecount(); try; MATEpanet2.ENsetNodeMixFraction(i, values(i)); catch ;end;end;end
function ENsetNodeTankKBulks  (values); for i=1:MATEpanet2.ENgetnodecount(); try; MATEpanet2.ENsetNodeTankKBulk  (i, values(i)); catch ;end;end;end
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
