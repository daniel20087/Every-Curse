local EveryCurseEveryFloor = RegisterMod("Every Curse", 1)

function EveryCurseEveryFloor:GiveEveryCurse()
    
    if Game().Challenge ~= Challenge.CHALLENGE_NULL or Game():IsGreedMode() then -- no greed or challenge
        return
    end

    -- Get current level.
    local level = Game():GetLevel()
    -- no void, hush, womb ii, mom
    local stage = level:GetAbsoluteStage()
    if stage == LevelStage.STAGE7 or stage == LevelStage.STAGE3_2 or stage == LevelStage.STAGE4_2 or stage == LevelStage.STAGE4_3 or stage == LevelStage.STAGE4_3 then
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

function EveryCurseEveryFloor:OnPickupMorph(pickup)
    if pickup.Variant ~= PickupVariant.PICKUP_COLLECTIBLE then return end
    if pickup.SubType ~= CollectibleType.COLLECTIBLE_BLACK_CANDLE then return end

    local randomItemID
    local isPassive = false
    local itemConfig = Isaac.GetItemConfig()

    while not isPassive do
        randomItemID = math.random(1, 719) --if anyone wants to maintain this code in the future go right ahead
        local collectibleConfig = itemConfig:GetCollectible(randomItemID)
        if collectibleConfig and collectibleConfig.Type == ItemType.ITEM_PASSIVE and randomItemID ~= CollectibleType.COLLECTIBLE_BLACK_CANDLE then
            isPassive = true
        end
    end

    pickup:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, randomItemID, true, true, true)
end

EveryCurseEveryFloor:AddCallback(ModCallbacks.MC_POST_CURSE_EVAL, EveryCurseEveryFloor.GiveEveryCurse)
EveryCurseEveryFloor:AddCallback(ModCallbacks.MC_POST_PICKUP_INIT, EveryCurseEveryFloor.OnPickupMorph)