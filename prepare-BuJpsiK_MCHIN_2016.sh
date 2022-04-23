#!/bin/bash

SCENARIO=$1
export SCRAM_ARCH=slc7_amd64_gcc530
source /cvmfs/cms.cern.ch/cmsset_default.sh

if [ -r $CMSSW_BASE/src ] ; then
  echo release CMSSW_8_0_31 already exists
else
  scram p CMSSW_8_0_31
fi
cd $CMSSW_BASE/src
eval `scram runtime -sh`

pyfile="BuJpsik_Pythia8_8p16TeV_TuneCUETP8M1_cfi.py"

#curl -s --insecure https://raw.githubusercontent.com/rreyesal/MCproduction_BuHIN/main/$pyfile --retry 2 --create-dirs -o Configuration/GenProduction/python/$pyfile

scram b
cd ../../
if [ "$SCENARIO" = "pPb" ]; 
then
    cmsDriver.py Configuration/GenProduction/python/$pyfile --python_filename step0-GS_BuJpsiK_Pythia8_8p16TeV_TuneCUETP8M1_GEN.py --eventcontent RAWSIM --customise Configuration/StandardSequences/SimWithCastor_cff.py,Configuration/DataProcessing/Utils.addMonitoring --datatier GEN-SIM  --pileup HiMixGEN --pileup_input "dbs:/ReggeGribovPartonMC_EposLHC_pPb_4080_4080_DataBS/pPb816Spring16GS-MB_80X_mcRun2_pA_v4-v2/GEN-SIM"  --fileout=step0-GS_BuJpsiK_Pythia8_8p16TeV_TuneCUETP8M1_GEN.root --conditions 80X_mcRun2_pA_v4 --beamspot MatchPPbBoost --step GEN,SIM --scenario HeavyIons --era Run2_2016_pA --no_exec  --mc -n 100000;

else 
    cmsDriver.py Configuration/GenProduction/python/$pyfile --python_filename step0-GS_BuJpsiK_Pythia8_8p16TeV_TuneCUETP8M1_GEN.py --eventcontent RAWSIM --customise Configuration/StandardSequences/SimWithCastor_cff.py,Configuration/DataProcessing/Utils.addMonitoring --datatier GEN-SIM  --pileup HiMixGEN --pileup_input "dbs:/ReggeGribovPartonMC_EposLHC_PbP_4080_4080_DataBS/pPb816Spring16GS-MB_80X_mcRun2_pA_v4-v2/GEN-SIM"  --fileout=step0-GS_BuJpsiK_Pythia8_8p16TeV_TuneCUETP8M1_GEN.root --conditions 80X_mcRun2_pA_v4 --beamspot MatchPbPBoost --step GEN,SIM --scenario HeavyIons --era Run2_2016_pA --no_exec  --mc -n 100000;

fi 

sed -i "20 a from IOMC.RandomEngine.RandomServiceHelper import RandomNumberServiceHelper \nrandSvc = RandomNumberServiceHelper(process.RandomNumberGeneratorService)\nrandSvc.populate()" step0-GS_BuJpsiK_Pythia8_8p16TeV_TuneCUETP8M1_GEN.py

sed -i "s/'\/store/\n'\/store/g" step0-GS_BuJpsiK_Pythia8_8p16TeV_TuneCUETP8M1_GEN.py 


export SCRAM_ARCH=slc7_amd64_gcc530
if [ -r $CMSSW_BASE/src ] ; then
  echo release CMSSW_8_0_31 already exists
else
  scram p CMSSW CMSSW_8_0_31
fi
cd $CMSSW_BASE/src
eval `scram runtime -sh`

scram b
cd ../../

if [ "$SCENARIO" = "pPb" ];
then 
   cmsDriver.py step1 --python_filename step1-DR_BuJpsiK_Pythia8_8p16TeV_TuneCUETP8M1_DIGI.py --eventcontent RAWSIM --customise Configuration/DataProcessing/Utils.addMonitoring --datatier GEN-SIM-RAW --fileout file:step1-DR_BuJpsiK_Pythia8_8p16TeV_TuneCUETP8M1_DIGI.root --pileup HiMix  --pileup_input  "dbs:/ReggeGribovPartonMC_EposLHC_pPb_4080_4080_DataBS/pPb816Spring16GS-MB_80X_mcRun2_pA_v4-v2/GEN-SIM" --conditions 80X_mcRun2_pA_v4 --step DIGI:pdigi_valid_nogen,L1,DIGI2RAW,HLT:PIon --filein file:step0-GS_BuJpsiK_Pythia8_8p16TeV_TuneCUETP8M1_GEN.root --era Run2_2016_pA --no_exec --mc -n -1;


else 
   cmsDriver.py step1 --python_filename step1-DR_BuJpsiK_Pythia8_8p16TeV_TuneCUETP8M1_DIGI.py --eventcontent RAWSIM --customise Configuration/DataProcessing/Utils.addMonitoring --datatier GEN-SIM-RAW --fileout file:step1-DR_BuJpsiK_Pythia8_8p16TeV_TuneCUETP8M1_DIGI.root --pileup HiMix  --pileup_input  "dbs:/ReggeGribovPartonMC_EposLHC_PbP_4080_4080_DataBS/pPb816Spring16GS-MB_80X_mcRun2_pA_v4-v2/GEN-SIM" --conditions 80X_mcRun2_pA_v4 --step DIGI:pdigi_valid_nogen,L1,DIGI2RAW,HLT:PIon --filein file:step0-GS_BuJpsiK_Pythia8_8p16TeV_TuneCUETP8M1_GEN.root --era Run2_2016_pA --no_exec --mc -n -1;

fi 

sed -i "20 a from IOMC.RandomEngine.RandomServiceHelper import RandomNumberServiceHelper\nrandSvc = RandomNumberServiceHelper(process.RandomNumberGeneratorService)\nrandSvc.populate() " step1-DR_BuJpsiK_Pythia8_8p16TeV_TuneCUETP8M1_DIGI.py

sed -i "s/'\/store/\n'\/store/g" step1-DR_BuJpsiK_Pythia8_8p16TeV_TuneCUETP8M1_DIGI.py

# cmsDriver command

cmsDriver.py step2 --python_filename step2-DR_BuJpsiK_Pythia8_8p16TeV_TuneCUETP8M1_RECO.py --eventcontent AODSIM --customise Configuration/DataProcessing/Utils.addMonitoring --datatier AODSIM --fileout file:step2-DR_BuJpsiK_Pythia8_8p16TeV_TuneCUETP8M1_RECO.root --conditions 80X_mcRun2_pA_v4 --customise_commands "process.bunchSpacingProducer.bunchSpacingOverride=cms.uint32(25)\n process.bunchSpacingProducer.overrideBunchSpacing=cms.bool(True)" --step RAW2DIGI,L1Reco,RECO --filein file:step1-DR_BuJpsiK_Pythia8_8p16TeV_TuneCUETP8M1_DIGI.root --era Run2_2016_pA --no_exec --mc -n -1;

sed -i "20 a from IOMC.RandomEngine.RandomServiceHelper import RandomNumberServiceHelper\nrandSvc = RandomNumberServiceHelper(process.RandomNumberGeneratorService)\nrandSvc.populate()" step2-DR_BuJpsiK_Pythia8_8p16TeV_TuneCUETP8M1_RECO.py


