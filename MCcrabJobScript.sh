#!/bin/bash

CHANNEL_DECAY="BuJpsiK"
YEAR="2016"

GEN_REL="CMSSW_8_0_31"
GEN_SCRAM="slc7_amd64_gcc530"
RECO_REL="CMSSW_8_0_31"
RECO_SCRAM="slc7_amd64_gcc530"
MINI_REL="CMSSW_8_0_31"
MINI_SCRAM="slc7_amd64_gcc530"

echo "================= cmssw environment prepration Gen step ===================="
source /cvmfs/cms.cern.ch/cmsset_default.sh
export SCRAM_ARCH=$GEN_SCRAM
if [ -r $GEN_REL/src ] ; then
  echo release $GEN_REL already exists
else
  scram p CMSSW $GEN_REL
fi
cd $GEN_REL/src
eval `scram runtime -sh`
scram b
cd ../../

echo "================= PB: CMSRUN starting Gen step ===================="
# PSet is the name that crab assigns to the config file of the job
cmsRun -j ${CHANNEL_DECAY}_step0.log  -p PSet.py


echo "================= cmssw environment prepration Reco step ===================="
export SCRAM_ARCH=$RECO_SCRAM
if [ -r $RECO_REL/src ] ; then
  echo release $RECO_REL already exists
else
  scram p CMSSW $RECO_REL
fi
cd $RECO_REL/src
eval `scram runtime -sh`
scram b
cd ../../

echo "================= PB: CMSRUN starting Reco step ===================="
cmsRun -e -j ${CHANNEL_DECAY}_step1.log step1-DR_BuJpsiK_Pythia8_8p16TeV_TuneCUETP8M1_DIGI.py

echo "================= PB: CMSRUN starting Reco step 2 ===================="
cmsRun -e -j FrameworkJobReport.xml  step2-DR_BuJpsiK_Pythia8_8p16TeV_TuneCUETP8M1_RECO.py

