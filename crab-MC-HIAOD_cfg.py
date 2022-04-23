from CRABClient.UserUtilities import config
import datetime
import time

config = config()

ts = time.time()
st = datetime.datetime.fromtimestamp(ts).strftime('%Y-%m-%d-%H-%M')

channel = 'BuJpsiK'
year = '2016'
step = 'PrivateMC-'+year
nEvents = 100000
NJOBS = 400
myrun = 'step0-GS_BuJpsiK_Pythia8_8p16TeV_TuneCUETP8M1_GEN.py'
myname = step+'-'+channel

config.General.requestName = step+'-'+channel+'-'+st
config.General.transferOutputs = True
config.General.transferLogs = False
config.General.workArea = 'crab_'+step+'-'+channel

config.JobType.allowUndistributedCMSSW = True
config.JobType.pluginName = 'PrivateMC'
config.JobType.psetName = myrun
config.JobType.inputFiles = ['step1-DR_BuJpsiK_Pythia8_8p16TeV_TuneCUETP8M1_DIGI.py',
                             'step2-DR_BuJpsiK_Pythia8_8p16TeV_TuneCUETP8M1_RECO.py']
config.JobType.disableAutomaticOutputCollection = True
config.JobType.eventsPerLumi = 10000
config.JobType.numCores = 1
config.JobType.maxMemoryMB = 3300
config.JobType.scriptExe = 'MCcrabJobScript.sh'

config.JobType.outputFiles = ['step2-DR_BuJpsiK_Pythia8_8p16TeV_TuneCUETP8M1_RECO.root']

config.Data.outputPrimaryDataset = myname
config.Data.splitting = 'EventBased'
config.Data.unitsPerJob = nEvents
config.Data.totalUnits = config.Data.unitsPerJob * NJOBS
config.Data.outLFNDirBase = '/store/user/rreyesal/Bphysics/' #% (getUsernameFromSiteDB())

config.Data.publication = False
config.Site.storageSite = 'T3_CH_CERNBOX'        
