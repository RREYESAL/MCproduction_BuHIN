# MCproduction_BuHIN

Steps to generate Private MC samples

* Create fragment for the desired decay

You can download fragment examples from https://cms-pdmv.cern.ch/mcm

In this tutorial we are using [BuJpsik](BuJpsik_Pythia8_8p16TeV_TuneCUETP8M1_cfi.py) as fragment.

* Edit and run the [prepare script](prepare-BuJpsiK_MCHIN_2016.sh). 
To run it, do: sh prepare-BuJpsiK_MCHIN_2016.sh pPb #(or Pbp)   
(Remember signing in to the GRID in order to find the pileup files in DAS (if necessary))

* You should have produced several python config files for all the steps

* Test locally using [the script](MCcrabJobScript.sh)

* Finally send the job using [crab config file](crab-MC-HIAOD_cfg.py)


Usefull references

https://twiki.cern.ch/twiki/bin/view/CMSPublic/WorkBookGeneration

https://twiki.cern.ch/twiki/bin/view/CMSPublic/WorkBookGenIntro

https://twiki.cern.ch/twiki/bin/view/CMSPublic/CRAB3ConfigurationFile

https://twiki.cern.ch/twiki/bin/view/CMSPublic/CRAB3AdvancedTutorial

https://twiki.cern.ch/twiki/bin/view/CMSPublic/CRAB3ConfigurationFile#CRAB_configuration_parameters
