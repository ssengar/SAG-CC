START /wait ant boot -Daccept.license=true
START /wait ant up
START /wait ant mirrors -Denv=default
START /wait cd antcc
START /wait ant up
