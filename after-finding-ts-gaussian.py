from chem_assistant import Settings, GaussJob
from glob import glob
import os

xyz = glob('*xyz')[0]

gas_free=Settings()
gas_free.input.freq = True
gas_free.input.method='M052X'
gas_free.input.basis='6-311+g(d,p)'
gas_free.meta.time='12:00:00'
gas_free.meta.mem='96gb'
gas_free.meta.nproc='24'

solv_free=Settings()
solv_free.input.freq = True
solv_free.input.method='M052X'
solv_free.input.basis='6-311+g(d,p)'
solv_free.input.scrf='smd,solvent=water'
solv_free.meta.time='12:00:00'
solv_free.meta.mem='96gb'
solv_free.meta.nproc='24'

gas_spec=Settings()
gas_spec.input.method='wB97XD'
gas_spec.input.basis='aug-cc-pVTZ'
gas_spec.meta.time='12:00:00'
gas_spec.meta.mem='96gb'
gas_spec.meta.nproc='32'

jobs = {'gas_free': gas_free,
        'solv_free': solv_free,
        'gas_spec': gas_spec}

# Create separate dirs and make jobs

cwd = os.getcwd()
for newdir, settings_file in jobs.items():
    if not os.path.isdir(newdir):
        os.mkdir(newdir)
    os.chdir(newdir)
    GaussJob(f'../{xyz}', settings=settings_file)
    os.chdir(cwd)
