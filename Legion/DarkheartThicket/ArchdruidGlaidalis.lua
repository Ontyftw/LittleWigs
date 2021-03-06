
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Archdruid Glaidalis", 1067, 1654)
if not mod then return end
mod:RegisterEnableMob(96512)
mod.engageId = 1836

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		198379, -- Primal Rampage
		198408, -- Nightfall
		{196376, "FLASH"}, -- Grievous Tear
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "PrimalRampage", 198379)

	self:Log("SPELL_AURA_APPLIED", "NightfallDamage", 198408)
	self:Log("SPELL_PERIODIC_DAMAGE", "NightfallDamage", 198408)
	self:Log("SPELL_PERIODIC_MISSED", "NightfallDamage", 198408)

	self:Log("SPELL_AURA_APPLIED", "GrievousTearApplied", 196376)
end

function mod:OnEngage()
	self:CDBar(198379, 12) -- Primal Rampage
	self:CDBar(196376, 5) -- Grievous Tear
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:PrimalRampage(args)
	self:Message(args.spellId, "Important", "Warning")
	self:CDBar(args.spellId, 30) -- pull:12.7, 30.3
end

do
	local prev = 0
	function mod:NightfallDamage(args)
		local t = GetTime()
		if t-prev > 2 and self:Me(args.destGUID) then
			prev = t
			self:Message(args.spellId, "Personal", "Alarm", CL.underyou:format(args.spellName))
		end
	end
end

function mod:GrievousTearApplied(args)
	if self:Me(args.destGUID) then
		self:Flash(args.spellId)
	end
	self:TargetMessage(args.spellId, args.destName, "Attention")
	self:CDBar(args.spellId, 13) -- pull:5.7, 14.5, 13.3
end

