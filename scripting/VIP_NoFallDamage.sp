#pragma semicolon 1
#pragma newdecls required

#include <sdkhooks>
#include <vip_core>

public Plugin myinfo =
{
	name = "[VIP] No Fall Damage",
	author = "R1KO (newdecls by PSIH :{ )",
	version = "1.0.2",
    url = "https://github.com/0RaKlE19/"
};

static const char g_sFeature[] = "NoFallDamage";

public void VIP_OnVIPLoaded(){VIP_RegisterFeature(g_sFeature, BOOL);}

public void OnPluginStart()
{
	for (int i = 1; i <= MaxClients; ++i)
	{
		if (IsClientInGame(i)) OnClientPutInServer(i);
	}
	if(VIP_IsVIPLoaded())
		VIP_OnVIPLoaded();
}

public void OnClientPutInServer(int iClient)
{
	SDKHook(iClient, SDKHook_OnTakeDamage, OnTakeDamage);
}
public Action OnTakeDamage(int iClient, int& attacker, int& inflictor, float& damage, int& damagetype)
{
	//PrintToChat(iClient, "damage: %f", damage);
	if(damagetype & DMG_FALL && VIP_IsClientFeatureUse(iClient, g_sFeature) && damage < 100)
		return Plugin_Handled;
	return Plugin_Continue;
}

public void OnPluginEnd() 
{
	if(CanTestFeatures() && GetFeatureStatus(FeatureType_Native, "VIP_UnregisterFeature") == FeatureStatus_Available)
		VIP_UnregisterFeature(g_sFeature);
}