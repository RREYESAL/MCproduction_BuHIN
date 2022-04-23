import FWCore.ParameterSet.Config as cms
from Configuration.Generator.Pythia8CommonSettings_cfi import *
from Configuration.Generator.Pythia8CUEP8M1Settings_cfi import *
#from GeneratorInterface.EvtGenInterface.EvtGenSetting_cff import *

generator = cms.EDFilter("Pythia8GeneratorFilter",
        pythiaPylistVerbosity = cms.untracked.int32(0),
        pythiaHepMCVerbosity = cms.untracked.bool(False),
        crossSection = cms.untracked.double(0),
        comEnergy = cms.double(8160.0),
        maxEventsToPrint = cms.untracked.int32(0),
        ExternalDecays = cms.PSet(
            EvtGen130 = cms.untracked.PSet(
                decay_table = cms.string('GeneratorInterface/EvtGenInterface/data/DECAY_2010.DEC'),
                particle_property_file = cms.FileInPath('GeneratorInterface/EvtGenInterface/data/evt.pdl'),
                user_decay_file = cms.vstring('GeneratorInterface/ExternalDecays/data/Bu_JpsiK.dec'),
                list_forced_decays = cms.vstring('MyB+',
                                                 'MyB-'),
                operates_on_particles = cms.vint32()
            ),
            parameterSets = cms.vstring('EvtGen130')
        ),
        PythiaParameters = cms.PSet(
            pythia8CommonSettingsBlock,
            pythia8CUEP8M1SettingsBlock,
            processParameters = cms.vstring(
                'HardQCD:all = on',
                'PhaseSpace:pTHatMin = 5.',
            ),
            parameterSets = cms.vstring('pythia8CommonSettings',
                                        'pythia8CUEP8M1Settings',
                                        'processParameters',
            )
        )
)

#generator.PythiaParameters.processParameters.extend(EvtGenExtraParticles)

###########
# Filters #
###########

bgenfilter = cms.EDFilter("PythiaDauVFilter",
    DaughterIDs = cms.untracked.vint32(321),
    MaxEta = cms.untracked.vdouble(2.5),
    MinEta = cms.untracked.vdouble(-2.5),
    MinPt = cms.untracked.vdouble(0.4),
    NumberDaughters = cms.untracked.int32(1),
    ParticleID = cms.untracked.int32(521),
    verbose = cms.untracked.int32(0)
)

mumugenfilter = cms.EDFilter("PythiaDauVFilter",
    DaughterIDs = cms.untracked.vint32(-13, 13),
    MaxEta = cms.untracked.vdouble(2.5, 2.5),
    MinEta = cms.untracked.vdouble(-2.5, -2.5),
    MinPt = cms.untracked.vdouble(1.5, 1.5),
    MotherID = cms.untracked.int32(521),
    NumberDaughters = cms.untracked.int32(2),
    ParticleID = cms.untracked.int32(443),
    verbose = cms.untracked.int32(0)
)

ProductionFilterSequence = cms.Sequence(generator+bgenfilter+mumugenfilter)
