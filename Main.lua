local XLCurseEveryFloor = RegisterMod("Every Curse", 1)

function XLCurseEveryFloor:GiveXLCurse()
    
    if Game().Challenge ~= Challenge.CHALLENGE_NULL or Game():IsGreedMode() then -- no greed or challenge
        return (
        LevelCurse.CURSE_OF_BLIND |
        LevelCurse.CURSE_OF_MAZE |
        LevelCurse.CURSE_OF_THE_LOST |
        LevelCurse.CURSE_OF_DARKNESS|
        LevelCurse.CURSE_OF_THE_UNKNOWN
    )
    end

    -- Get current level.
    local level = Game():GetLevel()

    -- stage is The Void (Stage 12) skip XL
    if level:GetAbsoluteStage() == LevelStage.STAGE7 then -- Dellirium Floor
        return (
        LevelCurse.CURSE_OF_BLIND |
        LevelCurse.CURSE_OF_MAZE |
        LevelCurse.CURSE_OF_THE_LOST |
        LevelCurse.CURSE_OF_DARKNESS|
        LevelCurse.CURSE_OF_THE_UNKNOWN
    )
    end

    -- stage is the Hush floor skip XL
    if level:GetAbsoluteStage() == LevelStage.STAGE4_3 then -- Hush floor
        return (
        LevelCurse.CURSE_OF_BLIND |
        LevelCurse.CURSE_OF_MAZE |
        LevelCurse.CURSE_OF_THE_LOST |
        LevelCurse.CURSE_OF_DARKNESS|
        LevelCurse.CURSE_OF_THE_UNKNOWN
    )
    end
    -- if its 2nd womb floor dont make it XL
    if level:GetAbsoluteStage() == LevelStage.STAGE4_2 then -- Womb 2nd floor
        return (
        LevelCurse.CURSE_OF_BLIND |
        LevelCurse.CURSE_OF_MAZE |
        LevelCurse.CURSE_OF_THE_LOST |
        LevelCurse.CURSE_OF_DARKNESS|
        LevelCurse.CURSE_OF_THE_UNKNOWN
    )
    end

    return (
        LevelCurse.CURSE_OF_LABYRINTH |
        LevelCurse.CURSE_OF_BLIND |
        LevelCurse.CURSE_OF_MAZE |
        LevelCurse.CURSE_OF_THE_LOST |
        LevelCurse.CURSE_OF_DARKNESS|
        LevelCurse.CURSE_OF_THE_UNKNOWN
    )
end

XLCurseEveryFloor:AddCallback(ModCallbacks.MC_POST_CURSE_EVAL, XLCurseEveryFloor.GiveXLCurse)
