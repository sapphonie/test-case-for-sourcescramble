#include <sourcemod>
#include <sourcescramble>

GameData tf2rue_gamedata;

public void OnPluginStart()
{
    DoGameData();
    DoMempatches();

    while (true)
    {
        //
    }
}

void DoGameData()
{
    // main gamedata cfg
    tf2rue_gamedata = LoadGameConfigFile("tf2.rue");
    if (tf2rue_gamedata == null)
    {
        SetFailState("Couldn't load gamedata");
    }
}

void DoMempatches()
{
    // For allowing mp_tournament_whitelist in mp_tournament 0
    MemoryPatch memp_ReloadWhitelist = MemoryPatch.CreateFromConf(tf2rue_gamedata, "CEconItemSystem::ReloadWhitelist::nopnop");

    if (!memp_ReloadWhitelist.Validate())
    {
        ThrowError("Failed to verify CEconItemSystem::ReloadWhitelist::nopnop");
    }
    else if (memp_ReloadWhitelist.Enable())
    {
        PrintToServer("-> Patched CEconItemSystem::ReloadWhitelist::nopnop");
    }
}
