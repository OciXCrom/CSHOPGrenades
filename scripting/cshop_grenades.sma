#include <amxmodx>
#include <cstrike>
#include <customshop>
#include <fun>

additem ITEM_GRENADES
new g_szGrenades[64]

public plugin_init()
{
	register_plugin("CSHOP: Grenades Pack", "1.0", "OciXCrom")
	cshop_get_string(ITEM_GRENADES, "Grenades", g_szGrenades, charsmax(g_szGrenades))
}

public plugin_precache()
{
	ITEM_GRENADES = cshop_register_item("grenades_pack", "Grenades Pack", 800)
	cshop_set_string(ITEM_GRENADES, "Grenades", "1 hegrenade, 2 flashbang, 1 smokegrenade")
}

public cshop_item_selected(id, iItem)
{
	if(iItem == ITEM_GRENADES)
	{
		new szData[2][64], szGrenade[20], szAmount[5]
		copy(szData[0], charsmax(szData[]), g_szGrenades)
		
		while(szData[0][0] && strtok(szData[0], szData[1], charsmax(szData[]), szData[0], charsmax(szData[]), ','))
		{
			trim(szData[0]); trim(szData[1])
			parse(szData[1], szAmount, charsmax(szAmount), szGrenade, charsmax(szGrenade))
			trim(szAmount); trim(szGrenade)
			format(szGrenade, charsmax(szGrenade), "weapon_%s", szGrenade)
			give_item(id, szGrenade)
			cs_set_user_bpammo(id, get_weaponid(szGrenade), str_to_num(szAmount))
		}
	}
}