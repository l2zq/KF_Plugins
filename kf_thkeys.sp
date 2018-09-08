#include <sourcemod>
#define CHR1 "■"
#define CHR2 "　"
public void OnPluginStart(){
}

public Action OnPlayerRunCmd(int client, int& buttons, int& impulse, float vel[3], float angles[3], int& weapon, int& subtype, int& cmdnum, int& tickcount, int& seed, int mouse[2]){
	static int prevbuttons[MAXPLAYERS+1];
	if(buttons!=prevbuttons[client]){
		SetHudTextParams(-1.0, 0.6, 60.0, 0x66, 0xCC, 0xFF, 0xFF, 0, 0.0, 0.0, 0.0);
		ShowHudText(client, 5, "%s　　%s　\n%s　%s%s%s", (buttons&IN_DUCK)?CHR1:CHR2, (buttons&IN_FORWARD)?CHR1:CHR2, (buttons&IN_JUMP)?CHR1:CHR2, (buttons&IN_MOVELEFT)?CHR1:CHR2, (buttons&IN_BACK)?CHR1:CHR2, (buttons&IN_MOVERIGHT)?CHR1:CHR2);
		buttons ^= -1;
		SetHudTextParams(-1.0, 0.6, 60.0, 0x7f, 0x7f, 0x7f, 0xFF, 0, 0.0, 0.0, 0.0);
		ShowHudText(client, 6, "%s　　%s　\n%s　%s%s%s", (buttons&IN_DUCK)?CHR1:CHR2, (buttons&IN_FORWARD)?CHR1:CHR2, (buttons&IN_JUMP)?CHR1:CHR2, (buttons&IN_MOVELEFT)?CHR1:CHR2, (buttons&IN_BACK)?CHR1:CHR2, (buttons&IN_MOVERIGHT)?CHR1:CHR2);
		buttons ^= -1;
		prevbuttons[client] = buttons;
	}
	return Plugin_Continue;
}
