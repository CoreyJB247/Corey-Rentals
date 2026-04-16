config = {}

-- target resource (only one of these can be true)
-------------------------------------------------------
config.qbtarget = false  
config.oxtarget = true  
-------------------------------------------------------


config.pedmodel = 'a_m_m_prolhost_01' -- ped model hash

config.scenario = 'WORLD_HUMAN_CLIPBOARD' -- scenario for ped to play, false to disable

config.locations = {
    ['lsia'] = {
        ped = true, -- if false uses boxzone (below)

        coords = vec4(-833.08, -2348.76, 14.56, 256.44),
        
        -------- boxzone (only used if ped is false) --------

        length = 1.0,  
        width = 1.0,   
        minZ = 30.81,  
        maxZ = 30.81,  
        debug = false, 

        -----------------------------------------------------
        vehicles = {
            ['imperial']    = {
                price = 180, 
                image = false,
            },
            ['08char']    = {
                price = 250, 
                image = false,
            },
            ['15exp']       = {
                price = 300, 
                image = false,
            },
            ['21f150']     = {
                price = 400, 
                image = false,
            },
        },

        vehiclespawncoords = vec4(-823.6, -2352.56, 14.56, 234.48), -- where vehicle spawns when rented

    },

    ['airportsandy'] = {
        ped = true, -- if false uses boxzone (below)

        coords = vec4(1733.48, 3324.96, 41.24, 194.32),
        
        -------- boxzone (only used if ped is false) --------

        length = 1.0,  
        width = 1.0,   
        minZ = 30.81,  
        maxZ = 30.81,  
        debug = false, 

        -----------------------------------------------------
        vehicles = {
            ['08char']    = {
                price = 250, 
                image = false,
            },
            ['19exp']       = {
                price = 300, 
                image = false,
            },
            ['21f150']     = {
                price = 400, 
                image = false,
            },

        },

        vehiclespawncoords = vec4(1733.4, 3317.88, 41.24, 201.68), -- where vehicle spawns when rented

    },

    -- add as many locations as you'd like with any type of vehicle (air, water, land) follow same format as above
}

