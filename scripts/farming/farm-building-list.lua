local farm_buildings = {
	['antelope-enclosure'] = 'animal',
	['arqad-hive'] = 'animal',
	['arthurian-pen'] = 'animal',
	['auog-paddock'] = 'animal',
	['cridren-enclosure'] = 'plant',
	['dhilmos-pool'] = 'animal',
	['dingrits-pack'] = 'animal',
	['fish-farm'] = 'animal',
	['kmauts-enclosure'] = 'animal',
	['mukmoux-pasture'] = 'animal',
	['phadai-enclosure'] = 'animal',
	['phagnot-corral'] = 'animal',
	['prandium-lab'] = 'animal',
	['ez-ranch'] = 'animal',
	['rc'] = 'animal',
	['scrondrix-pen'] = 'animal',
	['simik-den'] = 'animal',
	['trits-reef'] = 'animal',
	['ulric-corral'] = 'animal',
	['vonix-den'] = 'animal',
	['vrauks-paddock'] = 'animal',
	['xenopen'] = 'animal',
	['xyhiphoe-pool'] = 'animal',
	['zipir-reef'] = 'animal',
	['cadaveric-arum'] = 'plant',
	['fwf'] = 'plant',
	['grods-swamp'] = 'plant',
	['guar-gum-plantation'] = 'plant',
	['kicalk-plantation'] = 'plant',
	['moondrop-greenhouse'] = 'plant',
	['moss-farm'] = 'plant',
	['ralesia-plantation'] = 'plant',
	['rennea-plantation'] = 'plant',
	['sap-extractor'] = 'plant',
	['seaweed-crop'] = 'plant',
	['sponge-culture'] = 'plant',
	['tuuphra-plantation'] = 'plant',
	['yotoi-aloe-orchard'] = 'plant',
	['bhoddos-culture'] = 'fungi',
	['fawogae-plantation'] = 'fungi',
	['navens-culture'] = 'fungi',
	['yaedols-culture'] = 'fungi'
}

if script.active_mods['pyalternativeenergy'] then
    farm_buildings['zungror-lair'] = 'animal'
    farm_buildings['numal-reef'] = 'animal'
end

return farm_buildings