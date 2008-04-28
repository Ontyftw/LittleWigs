﻿------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Thorngrin the Tender"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Thorngrin",

	sacrifice = "Sacrifice",
	sacrifice_desc = "Warn for Sacrifice of players.",
	sacrifice_message = "%s is being Sacrificed!",
	sacrifice_bar = "Sacrifice: %s",
	sacrifice_soon = "Sacrifice soon!",
	sacrifice_soonbar = "~Possible Sacrifice",
} end )

L:RegisterTranslations("koKR", function() return {
	sacrifice = "희생",
	sacrifice_desc = "플레이어의 희생에 대한 경고입니다.",
	sacrifice_message = "%s님이 희생되었습니다!",
	sacrifice_bar = "희생: %s",
	sacrifice_soon = "잠시 후 희생!",
	sacrifice_soonbar = "~희생 대기시간",
} end )

L:RegisterTranslations("zhTW", function() return {
	sacrifice = "犧牲警告",
	sacrifice_desc = "當有玩家被犧牲時發送警告",
	sacrifice_message = "%s 犧牲了 - 注意停手及治療",
	sacrifice_bar = "犧牲：[%s]",
	sacrifice_soon = "即將施放犧牲!",
	sacrifice_soonbar = "~可能施放犧牲",
} end )

L:RegisterTranslations("zhCN", function() return {
	sacrifice = "牺牲",
	sacrifice_desc = "当玩家受到牺牲时发出警报。",
	sacrifice_message = ">%s< 牺牲！- 注意停手！",
	sacrifice_bar = "<牺牲：%s>",
	sacrifice_soon = "即将 牺牲！",
	sacrifice_soonbar = "<可能 牺牲>",
} end )

L:RegisterTranslations("frFR", function() return {
	sacrifice = "Sacrifice",
	sacrifice_desc = "Préviens quand un joueur est sacrifié.",
	sacrifice_message = "%s est sacrifié !",
	sacrifice_bar = "Sacrifice : %s",
	sacrifice_soon = "Sacrifice imminent !",
	sacrifice_soonbar = "~Sacrifice probable",
} end )

L:RegisterTranslations("deDE", function() return {
	sacrifice = "Opferung",
	sacrifice_desc = "Warnt welcher Spieler geopfert wird",
	sacrifice_message = "%s wird geopfert!",
	sacrifice_bar = "Opferung: %s",
	sacrifice_soon = "Opferung bald!",
	sacrifice_soonbar = "~Mögliche Opferung",
} end )

L:RegisterTranslations("esES", function() return {
	sacrifice = "Sacrificio",
	sacrifice_desc = "Avisa del Sacrificio de los jugadores.",
	sacrifice_message = "¡%s esta siendo sacrificado!",
	sacrifice_bar = "Sacrificio: %s",
	sacrifice_soon = "¡Sacrificio Pronto!",
	sacrifice_soonbar = "~Posible Sacrificio",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Tempest Keep"
mod.zonename = BZ["The Botanica"]
mod.enabletrigger = boss 
mod.toggleoptions = {"sacrifice", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_AURA_APPLIED", "Sacrifice", 34661)
	self:AddCombatListener("UNIT_DIED", "GenericBossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Sacrifice(player, spellID)
	if self.db.profile.sacrifice then
		self:IfMessage(L["sacrifice_message"]:format(player), "Attention", spellID)
		self:Bar(L["sacrifice_bar"]:format(player), 8, spellID)
		self:ScheduleEvent("sac1", "BigWigs_Message", 22, L["sacrifice_soon"], "Positive")
		self:Bar(L["sacrifice_soonbar"], 22, spellID)
	end
end
