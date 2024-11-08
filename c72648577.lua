--DDDの人事権
---@param c Card
function c72648577.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK+CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c72648577.target)
	e1:SetOperation(c72648577.operation)
	c:RegisterEffect(e1)
end
function c72648577.filter(c)
	return c:IsSetCard(0xaf) and c:IsAbleToDeck()
		and (not c:IsLocation(LOCATION_MZONE) or c:IsFaceup())
		and (c:IsType(TYPE_MONSTER) or c:IsLocation(LOCATION_PZONE))
end
function c72648577.thfilter(c)
	return c:IsSetCard(0xaf) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c72648577.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c72648577.filter,tp,LOCATION_MZONE+LOCATION_PZONE+LOCATION_GRAVE+LOCATION_HAND,0,3,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,3,tp,LOCATION_MZONE+LOCATION_PZONE+LOCATION_GRAVE+LOCATION_HAND)
end
function c72648577.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(aux.NecroValleyFilter(c72648577.filter),tp,LOCATION_MZONE+LOCATION_PZONE+LOCATION_GRAVE+LOCATION_HAND,0,nil)
	if g:GetCount()<3 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local sg=g:Select(tp,3,3,nil)
	local cg=sg:Filter(Card.IsLocation,nil,LOCATION_HAND)
	Duel.ConfirmCards(1-tp,cg)
	Duel.SendtoDeck(sg,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
	local og=Duel.GetOperatedGroup()
	if not og:IsExists(Card.IsLocation,1,nil,LOCATION_DECK+LOCATION_EXTRA) then return end
	local dg=Duel.GetMatchingGroup(c72648577.thfilter,tp,LOCATION_DECK,0,nil)
	if dg:GetCount()>1 and Duel.SelectYesNo(tp,aux.Stringid(72648577,0)) then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local tg=dg:Select(tp,2,2,nil)
		Duel.SendtoHand(tg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tg)
	else
		if og:IsExists(Card.IsLocation,1,nil,LOCATION_DECK) then
			Duel.ShuffleDeck(tp)
		end
	end
end
