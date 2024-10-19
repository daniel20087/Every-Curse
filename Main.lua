local XLCurseEveryFloor = RegisterMod("Every Curse", 1)

function XLCurseEveryFloor:GiveXLCurse()
    
    if Game().Challenge ~= Challenge.CHALLENGE_NULL or Game():IsGreedMode() then -- no greed or challenge
        return (
        LevelCurse.CURSE_OF_BLIND |
        LevelCurse.CURSE_OF_MAZE |
        LevelCurse.CURSE_OF_THE_LOST |
        LevelCurse.CURSE_OF_THE_UNKNOWN
    )
    end

    -- Get current level.
    local level = Game():GetLevel()

    -- stage is The Void (Stage 12) skip
    if level:GetAbsoluteStage() == LevelStage.STAGE7 then -- STAGE7 corresponds to The Void (Stage 12)
        return (
        LevelCurse.CURSE_OF_BLIND |
        LevelCurse.CURSE_OF_MAZE |
        LevelCurse.CURSE_OF_THE_LOST |
        LevelCurse.CURSE_OF_THE_UNKNOWN
    )
    end

    -- stage is the Hush floor skip
    if level:GetAbsoluteStage() == LevelStage.STAGE6 and level:IsAltStage() then -- STAGE6 (Stage 10) + AltStage for Hush
        return (
        LevelCurse.CURSE_OF_BLIND |
        LevelCurse.CURSE_OF_MAZE |
        LevelCurse.CURSE_OF_THE_LOST |
        LevelCurse.CURSE_OF_THE_UNKNOWN
    )
    end

    return (
        LevelCurse.CURSE_OF_LABYRINTH |
        LevelCurse.CURSE_OF_BLIND |
        LevelCurse.CURSE_OF_MAZE |
        LevelCurse.CURSE_OF_THE_LOST |
        LevelCurse.CURSE_OF_THE_UNKNOWN
    )
end

XLCurseEveryFloor:AddCallback(ModCallbacks.MC_POST_CURSE_EVAL, XLCurseEveryFloor.GiveXLCurse)