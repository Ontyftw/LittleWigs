
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Hymdall", 1041, 1485)
if not mod then return end
mod:RegisterEnableMob(94960)
mod.engageId = 1805

--------------------------------------------------------------------------------
-- Locals
--

local bladeCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		193235, -- Dancing Blade
		191284, -- Horn of Valor
		193092, -- Bloodletting Sweep
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "DancingBlade", 193235)
	self:Log("SPELL_CAST_START", "HornOfValor", 191284)

	self:Log("SPELL_PERIODIC_DAMAGE", "DancingBladeDamage", 193234)
	self:Log("SPELL_PERIODIC_MISSED", "DancingBladeDamage", 193234)

	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
end

function mod:OnEngage()
	bladeCount = 1
	self:CDBar(193235, 3.3) -- Dancing Blade
	self:CDBar(191284, 8) -- Horn of Valor
	self:CDBar(193092, 16) -- Bloodletting Sweep
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:DancingBlade(args)
	self:Message(args.spellId, "Urgent", "Alert", CL.incoming:format(args.spellName))
	self:CDBar(args.spellId, bladeCount % 2 == 0 and 10 or 31)
	bladeCount = bladeCount + 1
end

function mod:HornOfValor(args)
	self:Message(args.spellId, "Important", "Long", CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 42) -- 42.0-43.7
end

do
	local prev = 0
	function mod:DancingBladeDamage(args)
		local t = GetTime()
		if self:Me(args.destGUID) and t-prev > 2 then
			prev = t
			self:Message(193235, "Personal", "Alarm", CL.you:format(args.spellName))
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, _, spellId)
	if spellId == 193092 then -- Bloodletting Sweep
		self:Message(spellId, "Attention", self:Tank() and "Info")
		self:CDBar(spellId, 18) -- 18.2 - 23
	end
end

