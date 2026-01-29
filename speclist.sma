#include <amxmodx>
#include <amxmisc>
#include <fakemeta>

#define PLUGIN "SpecList"
#define VERSION "1.0"
#define AUTHOR "ftl~ & MrShark45"

#define UPDATEINTERVAL 1.0

#define TASK_ID 123094

new g_iHudSync;
new bool:gShowSpecList[33];
new bool:gHidePlayer[33];
new gCvarOn;
new gEnabled;

public plugin_init(){
	register_plugin(PLUGIN, VERSION, AUTHOR);

	gCvarOn = register_cvar("amx_speclist", "1");
	bind_pcvar_num(gCvarOn, gEnabled);

	register_clcmd("say /speclist", "toggleSpecList");
	register_clcmd("say_team /speclist", "toggleSpecList");

	register_clcmd("say /hide", "hidePlayer");
	register_clcmd("say_team /hide", "hidePlayer");

	g_iHudSync = CreateHudSyncObj();
	
	set_task(UPDATEINTERVAL, "SpecListHud", TASK_ID, "", 0, "b");
}

public plugin_natives(){
	register_library("spec_list");
	register_native("toggle_speclist", "native_toggle_speclist");
	register_native("get_bool_speclist", "native_get_bool_speclist");
}

public native_get_bool_speclist(NumParams){
	new id = get_param(1);
	return gShowSpecList[id];
}

public native_toggle_speclist(NumParams){
	new id = get_param(1);
	toggleSpecList(id);
}

public client_putinserver(id){
	gShowSpecList[id] = true;
	gHidePlayer[id] = true; // Admins start hidden (invisible) in speclist by default.
							// To appear in the speclist HUD, admins must use the /hide command (which toggles the state).
}

public toggleSpecList(id){
	gShowSpecList[id] = !gShowSpecList[id];
	return PLUGIN_HANDLED;
}

public hidePlayer(id)
{
	if(!is_user_admin(id)) return PLUGIN_HANDLED;

	gHidePlayer[id] = !gHidePlayer[id];

	return PLUGIN_HANDLED;
}

public SpecListHud(){
	if(!gEnabled) return PLUGIN_CONTINUE;
	
	static szHud[1024];
	static szName[32];
	static bool:hasSpectators;
	static bool:gShouldShow[33];

	for (new alive = 1; alive <= MAX_PLAYERS; alive++){
		if (!is_user_alive(alive)) continue;

		hasSpectators = false;
		szHud[0] = 0;
		for (new i = 1; i <= MAX_PLAYERS; i++) gShouldShow[i] = false;

		gShouldShow[alive] = true;
		get_user_name(alive, szName, charsmax(szName));
		formatex(szHud, charsmax(szHud), "Spectating: %s^n", szName);

		for (new dead = 1; dead <= MAX_PLAYERS; dead++){
			if (!is_user_connected(dead) || is_user_alive(dead) || is_user_bot(dead))
				continue;

			if (pev(dead, pev_iuser2) == alive){
				gShouldShow[dead] = true;

				if (gHidePlayer[dead])
					continue;

				get_user_name(dead, szName, charsmax(szName));
				add(szHud, charsmax(szHud), szName, 0);
				add(szHud, charsmax(szHud), "^n", 0);
				hasSpectators = true;
			}
		}

		if (hasSpectators){
			for (new i = 1; i <= MAX_PLAYERS; i++){
				if (gShouldShow[i] && gShowSpecList[i] && is_user_connected(i)){
					set_hudmessage(128, 128, 128, 0.75, 0.15, 0, 0.0, UPDATEINTERVAL + 0.1, 0.0, 0.0, -1);
					ShowSyncHudMsg(i, g_iHudSync, szHud);
				}
			}
		}
	}
	return PLUGIN_CONTINUE;
}