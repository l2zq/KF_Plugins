#include <sourcemod>

#define FW_W "Ｗ"
#define FW_S "Ｓ"
#define FW_A "Ａ"
#define FW_D "Ｄ"
#define FW_C "Ｃ"
#define FW_J "Ｊ"
#define FW_SPC "　"
#define FW_BLK "■"
#define FW_LARROW "←"
#define FW_RARROW "→"

char W[2][4] = {FW_SPC, FW_W};
char S[2][4] = {FW_SPC, FW_S};
char A[2][4] = {FW_SPC, FW_A};
char D[2][4] = {FW_SPC, FW_D};
char C[2][4] = {FW_SPC, FW_C};
char J[2][4] = {FW_SPC, FW_J};
char angSignL[3][4] = {FW_LARROW, FW_SPC, FW_SPC};
char angSignR[3][4] = {FW_SPC, FW_SPC, FW_RARROW};
int K(int a, int b){ if(a&b) return 1; return 0; }

public void OnPluginStart(){
}
public Action OnPlayerRunCmd(int client, int& buttons, int& impulse, float vel[3], float angles[3], int& weapon, int& subtype, int& cmdnum, int& tickcount, int& seed, int mouse[2]){
	static float _prevyaw[MAXPLAYERS+1];
	static int _prevbuttons[MAXPLAYERS+1];
	static int _prevdangsign[MAXPLAYERS+1];
	#define yaw angles[1]
	#define prevyaw _prevyaw[client]
	#define prevbuttons _prevbuttons[client]
	#define prevdangsign _prevdangsign[client]
	float dang = yaw-prevyaw;
	if(dang<-180.0) dang+=360.0;
	if(dang>180.0) dang-=360.0;
	int dangsign = dang>0.0?0:dang<0.0?2:1;
	if(buttons!=prevbuttons||dangsign!=prevdangsign){
		SetHudTextParams(-1.0, 0.6, 1.0, 0x66, 0xCC, 0xFF, 0xFF, 0, 0.0, 0.0, 0.0);
		ShowHudText(client, 2, "%s\n"...
													 "%s%s%s%s%s\n"...
													   "%s%s%s",
													 W[K(buttons,IN_FORWARD)],
													 angSignL[dangsign],    A[K(buttons,IN_MOVELEFT)], S[K(buttons,IN_BACK)], D[K(buttons,IN_MOVERIGHT)], angSignR[dangsign],
													 C[K(buttons,IN_DUCK)], FW_SPC, J[K(buttons,IN_JUMP)]);
		//ShowHudText(client, 2, "%s", W[K(buttons,IN_FORWARD)]);
		prevbuttons = buttons;
		prevdangsign = dangsign;
	}
	prevyaw = yaw;
	return Plugin_Continue;
}