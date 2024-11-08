--月華竜 ブラック・ローズ
---@param c Card
function c33698022.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--tohand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(33698022,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,33698022)
	e1:SetTarget(c33698022.thtg)
	e1:SetOperation(c33698022.thop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetDescription(aux.Stringid(33698022,1))
	e2:SetCode(EVENT_CUSTOM+33698022)
	c:RegisterEffect(e2)
	--event
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c33698022.evcon)
	e3:SetOperation(c33698022.evop)
	c:RegisterEffect(e3)
end
function c33698022.cfilter(c,tp)
	return c:IsFaceup() and c:IsLevelAbove(5) and c:IsControler(tp)
end
function c33698022.evcon(e,tp,eg,ep,ev,re,r,rp)
	return not eg:IsContains(e:GetHandler()) and eg:IsExists(c33698022.cfilter,1,nil,1-tp)
end
function c33698022.evop(e,tp,eg,ep,ev,re,r,rp)
	Duel.RaiseSingleEvent(e:GetHandler(),EVENT_CUSTOM+33698022,re,r,rp,ep,ev)
end
function c33698022.filter(c)
	return c:IsSummonType(SUMMON_TYPE_SPECIAL) and c:IsAbleToHand()
end
function c33698022.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c33698022.filter(chkc) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,c33698022.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,g:GetCount(),0,0)
end
function c33698022.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
