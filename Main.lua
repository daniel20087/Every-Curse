local EveryCurseEveryFloor = RegisterMod("Every Curse", 1)

function EveryCurseEveryFloor:GiveEveryCurse()
    
    if Game().Challenge ~= Challenge.CHALLENGE_NULL or Game():IsGreedMode() then -- no greed or challenge
        return
    end

    -- Get current level.
    local level = Game():GetLevel()
    local isaacPlayerID = Isaac.GetPlayer()
    -- no void, hush, womb ii, mom
    local stageCurse = level:GetAbsoluteStage()
    if stageCurse == LevelStage.STAGE7 or stageCurse == LevelStage.STAGE3_2 or stageCurse == LevelStage.STAGE4_2 or stageCurse == LevelStage.STAGE4_3 or stageCurse == LevelStage.STAGE4_3 then
        return (
        LevelCurse.CURSE_OF_BLIND |
        LevelCurse.CURSE_OF_MAZE |
        LevelCurse.CURSE_OF_THE_LOST |
        LevelCurse.CURSE_OF_DARKNESS|
        LevelCurse.CURSE_OF_THE_UNKNOWN
        )
    end
    local hasKeyPiece1 = isaacPlayerID:GetCollectibleNum(CollectibleType.COLLECTIBLE_KEY_PIECE_1)
    local hasKeyPiece2 = isaacPlayerID:GetCollectibleNum(CollectibleType.COLLECTIBLE_KEY_PIECE_2)
    if stageCurse == LevelStage.STAGE6 then -- this is for the player to be able to reach void in a run as void portal doesnt spawn in blue baby fight
        if hasKeyPiece1 == 0 then
            isaacPlayerID:AddCollectible(CollectibleType.COLLECTIBLE_KEY_PIECE_1)
        end

        if hasKeyPiece2 == 0 then
            isaacPlayerID:AddCollectible(CollectibleType.COLLECTIBLE_KEY_PIECE_2)
        end

        return(
        LevelCurse.CURSE_OF_LABYRINTH |
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
function EveryCurseEveryFloor:MegaSatanWarning()
    local isaacHud = Game():GetHUD()
    if Game():GetLevel():GetAbsoluteStage() == LevelStage.STAGE6 then

        isaacHud:ShowFortuneText("Go through mega satan to reach void")
        
    end
end

EveryCurseEveryFloor:AddCallback(ModCallbacks.MC_POST_CURSE_EVAL, EveryCurseEveryFloor.GiveEveryCurse)
EveryCurseEveryFloor:AddCallback(ModCallbacks.MC_POST_PICKUP_INIT, EveryCurseEveryFloor.OnPickupMorph)
EveryCurseEveryFloor:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, EveryCurseEveryFloor.MegaSatanWarning)