From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: [PATCH] acpi4asus update
Date: Tue, 27 Jan 2004 23:13:41 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040127221341.GA19793@hell.org.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AhhlLboLdkugWU4S"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline

Hi,
The attached patch updates the acpi4asus driver to 0.27 through the
following changes:
- add support for M1300A, S5200N, L8400L,
- remove WLED support for certain models, since it is not controlled by
  AML,
- add LCD backlight switching for L2E / L3H,
- C99 initializers,
- generic LED handlers,
- the output of ASYM method to provide battery state information (might be
  more accurate under certain conditions) in /proc/acpi/asus/info,
- fix several oddities, various clean-ups and other minor changes.

The patch itself is quite big, which is mostly due to the C99 initializers
and the fact that diff doesn't like moving code around.

This has been compile-tested in various configurations, the substantive
changes were discussed on the acpi4asus mailing list.

The code should apply to current bk (both for 2.4 and 2.6). The patch is
also available here:
http://hell.org.pl/~sziwan/asus/acpi4asus-0.26-0.27.diff

Thanks to all the contributors (notably Pontus Fuchs) to this release.

Please apply, TIA,
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org

--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: attachment; filename="acpi4asus-0.26-0.27.diff"

--- a/drivers/acpi/asus_acpi.c	2003-11-26 21:43:31.000000000 +0100
+++ b/drivers/acpi/asus_acpi.c	2004-01-27 04:36:29.000000000 +0100
@@ -2,7 +2,7 @@
  *  asus_acpi.c - Asus Laptop ACPI Extras
  *
  *
- *  Copyright (C) 2002, 2003 Julien Lerouge, Karol Kozimor
+ *  Copyright (C) 2002, 2003, 2004 Julien Lerouge, Karol Kozimor
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -23,16 +23,16 @@
  *  http://sourceforge.net/projects/acpi4asus/
  *
  *  Credits:
+ *  Pontus Fuchs   - Helper functions, cleanup
  *  Johann Wiesner - Small compile fixes
  *  John Belmonte  - ACPI code for Toshiba laptop was a good starting point.
  *
  *  TODO:
  *  add Fn key status
  *  Add mode selection on module loading (parameter) -> still necessary?
- *  Complete display switching -- may require dirty hacks?
+ *  Complete display switching -- may require dirty hacks or calling _DOS?
  */
 
-#include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -41,12 +41,13 @@
 #include <acpi/acpi_drivers.h>
 #include <acpi/acpi_bus.h>
 
-#define ASUS_ACPI_VERSION "0.26"
+#define ASUS_ACPI_VERSION "0.27"
 
 #define PROC_ASUS       "asus"	//the directory
 #define PROC_MLED       "mled"
 #define PROC_WLED       "wled"
-#define PROC_INFOS      "info"
+#define PROC_TLED       "tled"
+#define PROC_INFO       "info"
 #define PROC_LCD        "lcd"
 #define PROC_BRN        "brn"
 #define PROC_DISP       "disp"
@@ -67,6 +68,7 @@
  */
 #define MLED_ON     0x01	//is MLED ON ?
 #define WLED_ON     0x02
+#define TLED_ON     0x04
 
 MODULE_AUTHOR("Julien Lerouge, Karol Kozimor");
 MODULE_DESCRIPTION(ACPI_HOTK_NAME);
@@ -81,22 +83,25 @@ MODULE_PARM(asus_gid, "i");
 MODULE_PARM_DESC(gid, "GID for entries in /proc/acpi/asus.\n");
 
 
-/* For each model, all features implemented */
+/* For each model, all features implemented, 
+ * those marked with R are relative to HOTK, A for absolute */
 struct model_data {
-	char *name;		//name of the laptop
-	char *mt_mled;		//method to handle mled
-	char *mled_status;	//node to handle mled reading
-	char *mt_wled;		//method to handle wled
-	char *wled_status;	//node to handle wled reading
-	char *mt_lcd_switch;	//method to turn LCD ON/OFF
-	char *lcd_status;	//node to read LCD panel state
-	char *brightness_up;	//method to set brightness up
-	char *brightness_down;	//guess what ?
-	char *brightness_set;	//method to set absolute brightness
-	char *brightness_get;	//method to get absolute brightness
-	char *brightness_status;//node to get brightness
-	char *display_set;	//method to set video output
-	char *display_get;	//method to get video output
+	char *name;              //name of the laptop________________A
+	char *mt_mled;           //method to handle mled_____________R
+	char *mled_status;       //node to handle mled reading_______A
+	char *mt_wled;           //method to handle wled_____________R
+	char *wled_status;       //node to handle wled reading_______A
+ 	char *mt_tled;           //method to handle tled_____________R
+ 	char *tled_status;       //node to handle tled reading_______A
+	char *mt_lcd_switch;     //method to turn LCD ON/OFF_________A
+	char *lcd_status;        //node to read LCD panel state______A
+	char *brightness_up;     //method to set brightness up_______A
+	char *brightness_down;   //guess what ?______________________A
+	char *brightness_set;    //method to set absolute brightness_R
+	char *brightness_get;    //method to get absolute brightness_R
+	char *brightness_status; //node to get brightness____________A
+	char *display_set;       //method to set video output________R
+	char *display_get;       //method to get video output________R
 };
 
 /*
@@ -104,91 +109,239 @@ struct model_data {
  * about the hotk device
  */
 struct asus_hotk {
-	struct acpi_device *device;	//the device we are in
-	acpi_handle handle;		//the handle of the hotk device
-	char status;			//status of the hotk, for LEDs, ...
-	struct model_data *methods;	//methods available on the laptop
-	u8 brightness;			//brighness level
+	struct acpi_device *device; //the device we are in
+	acpi_handle handle;         //the handle of the hotk device
+	char status;                //status of the hotk, for LEDs, ...
+	struct model_data *methods; //methods available on the laptop
+	u8 brightness;              //brightness level
 	enum {
-		A1X=0,  	//A1340D, A1300F
-		A2X,		//A2500H
-		D1X,		//D1
-		L1X,		//L1400B
-		L2X,		//L2000D -> TODO check Q11 (Fn+F8)
-				//	   Calling this method simply hangs the
-				//	   computer, ISMI method hangs the laptop.
-		L3D,		//L3400D
-		L3X,		//L3C
-		L5X,		//L5C TODO this model seems to have one more
-		                //         LED, add support
-		M2X,		//M2400E
-		M3N,		//M3700N, but also S1300N -> TODO WLED
-		S1X,		//S1300A -> TODO special keys do not work ?
-		S2X,		//S200 (J1 reported), Victor MP-XP7210
-				//TODO  A1370D does not seem to have an ATK device 
-				//	L8400 model doesn't have ATK
+		A1x = 0,  //A1340D, A1300F
+		A2x,      //A2500H
+		D1x,      //D1
+		L2D,      //L2000D
+		L3C,      //L3800C
+		L3D,      //L3400D
+		L3H,      //L3H, but also L2000E
+		L5x,      //L5800C 
+		L8L,      //L8400L
+		M1A,      //M1300A
+		M2E,      //M2400E
+		S1x,      //S1300A, but also L1400B and M2400A (L84F)
+		S2x,      //S200 (J1 reported), Victor MP-XP7210
+		          //TODO  A1370D does not seem to have an ATK device 
+		          // L8400 model doesn't have ATK
+		xxN,      //M2400N, M3700N, S1300N (Centrino)
 		END_MODEL
-	} model;		//Models currently supported
-	u16 event_count[128];	//count for each event TODO make this better
+	} model;              //Models currently supported
+	u16 event_count[128]; //count for each event TODO make this better
 };
 
 /* Here we go */
-#define L3X_PREFIX "\\_SB.PCI0.PX40.ECD0."
-#define S1X_PREFIX "\\_SB.PCI0.PX40."
-#define L1X_PREFIX S1X_PREFIX
-#define A1X_PREFIX "\\_SB.PCI0.ISA.EC0."
-#define S2X_PREFIX A1X_PREFIX
-#define M3N_PREFIX "\\_SB.PCI0.SBRG.EC0."
+#define A1x_PREFIX "\\_SB.PCI0.ISA.EC0."
+#define L3C_PREFIX "\\_SB.PCI0.PX40.ECD0."
+#define M1A_PREFIX "\\_SB.PCI0.PX40.EC0."
+#define S1x_PREFIX "\\_SB.PCI0.PX40."
+#define S2x_PREFIX A1x_PREFIX
+#define xxN_PREFIX "\\_SB.PCI0.SBRG.EC0."
 
 static struct model_data model_conf[END_MODEL] = {
         /*
-	 * name|  mled |mled read|  wled |wled read| lcd sw |lcd read | 
-	 * br up|br down | br set | br read | br status|set disp | get disp
-	 *
-	 * br set and read shall be in hotk device !
-	 * same for set disp
+	 * Those pathnames are relative to the HOTK / ATKD device :
+	 *       - mt_mled
+	 *       - mt_wled
+	 *       - brightness_set
+	 *       - brightness_get
+	 *       - display_set
+	 *       - display_get
 	 *
 	 * TODO I have seen a SWBX and AIBX method on some models, like L1400B,
 	 * it seems to be a kind of switch, but what for ?
 	 *
 	 */
-	{"A1X", "MLED", "\\MAIL", NULL, NULL, A1X_PREFIX "_Q10", "\\BKLI",
-	 A1X_PREFIX "_Q0E", A1X_PREFIX "_Q0F", NULL, NULL, NULL, NULL, NULL},
-
-	{"A2X", "MLED", NULL, "WLED", "\\SG66", "\\Q10", "\\BAOF",
-	 "\\Q0E", "\\Q0F", "SPLV", "GPLV", "\\CMOD", "SDSP", "\\INFB"},
-
-	{"D1X", "MLED", NULL, NULL, NULL, "\\Q0D", "\\GP11", 
-	 "\\Q0C", "\\Q0B", NULL, NULL, "\\BLVL", "SDSP","\\INFB"},
 
-	{"L1X", "MLED", NULL, "WLED", NULL, L1X_PREFIX "Q10", "\\PNOF", 
-	 L1X_PREFIX "Q0F", L1X_PREFIX "Q0E", "SPLV", "GPLV", "\\BRIT", NULL, NULL},
-	 
-	{"L2X", "MLED", "\\SGP6", "WLED", "\\RCP3", "\\Q10", "\\SGP0", 
-	 "\\Q0E", "\\Q0F", NULL, NULL, NULL, "SDSP", "\\INFB"},
-
-	{"L3D", "MLED", "\\MALD", "WLED", NULL, "\\Q10", "\\BKLG",
-	 "\\Q0E", "\\Q0F", "SPLV", "GPLV", "\\BLVL", "SDSP", "\\INFB"},
-
-	{"L3X", "MLED", NULL, "WLED", NULL, L3X_PREFIX "_Q10", "\\GL32", 
-	 L3X_PREFIX "_Q0F", L3X_PREFIX "_Q0E", "SPLV", "GPLV", "\\BLVL", "SDSP", 
-	 "\\_SB.PCI0.PCI1.VGAC.NMAP"},
-
-	{"L5X", "MLED", NULL, "WLED", "WRED", "\\Q0D", "\\BAOF", 
-	 "\\Q0C","\\Q0B", "SPLV", "GPLV", NULL, "SDSP", "\\INFB"},
-	 
-	{"M2X", "MLED", NULL, "WLED", NULL, "\\Q10", "\\GP06", 
-	 "\\Q0E","\\Q0F", "SPLV", "GPLV", NULL, "SDSP", "\\INFB"},
-
-	{"M3N", "MLED", NULL, "WLED", "\\PO33", M3N_PREFIX "_Q10", "\\BKLT", 
-	 M3N_PREFIX "_Q0F", M3N_PREFIX "_Q0E", "SPLV", "GPLV", "\\LBTN", "SDSP", 
-	 "\\ADVG"},
-	
-	{"S1X", "MLED", "\\EMLE", "WLED", NULL, S1X_PREFIX "Q10", "\\PNOF", 
-	 S1X_PREFIX "Q0F", S1X_PREFIX "Q0E", "SPLV", "GPLV", "\\BRIT", NULL, NULL},
-	
-	{"S2X", "MLED", "\\MAIL", NULL, NULL, S2X_PREFIX "_Q10", "\\BKLI",
-	 S2X_PREFIX "_Q0B", S2X_PREFIX "_Q0A", NULL, NULL, NULL, NULL, NULL}
+	{
+		.name              = "A1x",
+		.mt_mled           = "MLED",
+		.mled_status       = "\\MAIL",
+		.mt_lcd_switch     = A1x_PREFIX "_Q10",
+		.lcd_status        = "\\BKLI",
+		.brightness_up     = A1x_PREFIX "_Q0E",
+		.brightness_down   = A1x_PREFIX "_Q0F",
+	},
+
+	{
+		.name              = "A2x",
+		.mt_mled           = "MLED",
+		.mt_wled           = "WLED",
+		.wled_status       = "\\SG66",
+		.mt_lcd_switch     = "\\Q10",
+		.lcd_status        = "\\BAOF",
+		.brightness_up     = "\\Q0E",
+		.brightness_down   = "\\Q0F",
+		.brightness_set    = "SPLV",
+		.brightness_get    = "GPLV",
+		.brightness_status = "\\CMOD",
+		.display_set       = "SDSP",
+		.display_get       = "\\INFB"
+	},
+
+	{
+		.name              = "D1x",
+		.mt_mled           = "MLED",
+		.mt_lcd_switch     = "\\Q0D",
+		.lcd_status        = "\\GP11",
+		.brightness_up     = "\\Q0C",
+		.brightness_down   = "\\Q0B",
+		.brightness_status = "\\BLVL",
+		.display_set       = "SDSP",
+		.display_get       = "\\INFB"
+	},
+
+	{
+		.name              = "L2D",
+		.mt_mled           = "MLED",
+		.mled_status       = "\\SGP6",
+		.mt_wled           = "WLED",
+		.wled_status       = "\\RCP3",
+		.mt_lcd_switch     = "\\Q10",
+		.lcd_status        = "\\SGP0",
+		.brightness_up     = "\\Q0E",
+		.brightness_down   = "\\Q0F",
+		.display_set       = "SDSP",
+		.display_get       = "\\INFB"
+	},
+
+	{
+		.name              = "L3C",
+		.mt_mled           = "MLED",
+		.mt_wled           = "WLED",
+		.mt_lcd_switch     = L3C_PREFIX "_Q10",
+		.lcd_status        = "\\GL32",
+		.brightness_up     = L3C_PREFIX "_Q0F",
+		.brightness_down   = L3C_PREFIX "_Q0E",
+		.brightness_set    = "SPLV",
+		.brightness_get    = "GPLV",
+		.brightness_status = "\\BLVL",
+		.display_set       = "SDSP",
+		.display_get       = "\\_SB.PCI0.PCI1.VGAC.NMAP"
+	},
+
+	{
+		.name              = "L3D",
+		.mt_mled           = "MLED",
+		.mled_status       = "\\MALD",
+		.mt_wled           = "WLED",
+		.mt_lcd_switch     = "\\Q10",
+		.lcd_status        = "\\BKLG",
+		.brightness_up     = "\\Q0E",
+		.brightness_down   = "\\Q0F",
+		.brightness_set    = "SPLV",
+		.brightness_get    = "GPLV",
+		.brightness_status = "\\BLVL",
+		.display_set       = "SDSP",
+		.display_get       = "\\INFB"
+	},
+
+	{
+		.name              = "L3H",
+		.mt_mled           = "MLED",
+		.mt_wled           = "WLED",
+		.mt_lcd_switch     = "EHK",
+		.lcd_status        = "\\_SB.PCI0.PM.PBC",
+		.brightness_set    = "SPLV",
+		.brightness_get    = "GPLV",
+		.display_set       = "SDSP",
+		.display_get       = "\\INFB"
+	},
+
+	{
+		.name              = "L5x",
+		.mt_mled           = "MLED",
+//		.mt_wled           = "WLED",
+//		.wled_status       = "\\WRED",
+/* Present, but not controlled by ACPI */
+		.mt_tled           = "TLED",
+		.mt_lcd_switch     = "\\Q0D",
+		.lcd_status        = "\\BAOF",
+		.brightness_up     = "\\Q0C",
+		.brightness_down   = "\\Q0B",
+		.brightness_set    = "SPLV",
+		.brightness_get    = "GPLV",
+		.display_set       = "SDSP",
+		.display_get       = "\\INFB"
+	},
+
+	{
+		.name              = "L8L"
+/* No features, but at least support the hotkeys */
+	},
+
+	{
+		.name              = "M1A",
+		.mt_mled           = "MLED",
+		.mt_lcd_switch     = M1A_PREFIX "Q10",
+		.lcd_status        = "\\PNOF",
+		.brightness_up     = M1A_PREFIX "Q0E",
+		.brightness_down   = M1A_PREFIX "Q0F",
+		.brightness_status = "\\BRIT",
+		.display_set       = "SDSP",
+		.display_get       = "\\INFB"
+	},
+
+	{
+		.name              = "M2E",
+		.mt_mled           = "MLED",
+		.mt_wled           = "WLED",
+		.mt_lcd_switch     = "\\Q10",
+		.lcd_status        = "\\GP06",
+		.brightness_up     = "\\Q0E",
+		.brightness_down   = "\\Q0F",
+		.brightness_set    = "SPLV",
+		.brightness_get    = "GPLV",
+		.display_set       = "SDSP",
+		.display_get       = "\\INFB"
+	},
+
+	{
+		.name              = "S1x",
+		.mt_mled           = "MLED",
+		.mled_status       = "\\EMLE",
+		.mt_wled           = "WLED",
+		.mt_lcd_switch     = S1x_PREFIX "Q10" ,
+		.lcd_status        = "\\PNOF",
+		.brightness_up     = S1x_PREFIX "Q0F",
+		.brightness_down   = S1x_PREFIX "Q0E",
+		.brightness_set    = "SPLV",
+		.brightness_get    = "GPLV",
+		.brightness_status = "\\BRIT",
+	},
+
+	{
+		.name              = "S2x",
+		.mt_mled           = "MLED",
+		.mled_status       = "\\MAIL",
+		.mt_lcd_switch     = S2x_PREFIX "_Q10",
+		.lcd_status        = "\\BKLI",
+		.brightness_up     = S2x_PREFIX "_Q0B",
+		.brightness_down   = S2x_PREFIX "_Q0A",
+	},
+
+	{
+		.name              = "xxN",
+		.mt_mled           = "MLED",
+//		.mt_wled           = "WLED",
+//		.wled_status       = "\\PO33",
+/* Present, but not controlled by ACPI */
+		.mt_lcd_switch     = xxN_PREFIX "_Q10",
+		.lcd_status        = "\\BKLT",
+		.brightness_up     = xxN_PREFIX "_Q0F",
+		.brightness_down   = xxN_PREFIX "_Q0E",
+		.brightness_set    = "SPLV",
+		.brightness_get    = "GPLV",
+		.brightness_status = "\\LBTN",
+		.display_set       = "SDSP",
+		.display_get       = "\\ADVG"
+	}
 };
 
 /* procdir we use */
@@ -264,7 +417,7 @@ proc_read_info(char *page, char **start,
 		void *data)
 {
 	int len = 0;
-	int sfun;
+	int temp;
 	struct asus_hotk *hotk = (struct asus_hotk *) data;
 	char buf[16];		//enough for all info
 	/*
@@ -275,8 +428,23 @@ proc_read_info(char *page, char **start,
 	len += sprintf(page, ACPI_HOTK_NAME " " ASUS_ACPI_VERSION "\n");
 	len += sprintf(page + len, "Model reference    : %s\n", 
 		       hotk->methods->name);
-	if(read_acpi_int(hotk->handle, "SFUN", &sfun))
-		len += sprintf(page + len, "SFUN value         : 0x%04x\n", sfun);
+	/* 
+	 * The SFUN method probably allows the original driver to get the list 
+	 * of features supported by a given model. For now, 0x0100 or 0x0800 
+	 * bit signifies that the laptop is equipped with a Wi-Fi MiniPCI card.
+	 * The significance of others is yet to be found.
+	 */
+	if (read_acpi_int(hotk->handle, "SFUN", &temp))
+		len += sprintf(page + len, "SFUN value         : 0x%04x\n", temp);
+	/*
+	 * Another value for userspace: the ASYM method returns 0x02 for
+	 * battery low and 0x04 for battery critical, it's readings tend to be
+	 * more accurate than those provided by _BST. 
+	 * Note: since not all the laptops provide this method, errors are
+	 * silently ignored.
+	 */
+	if (read_acpi_int(hotk->handle, "ASYM", &temp))
+		len += sprintf(page + len, "ASYM value         : 0x%04x\n", temp);
 	if (asus_info) {
 		snprintf(buf, 16, "%d", asus_info->length);
 		len += sprintf(page + len, "DSDT length        : %s\n", buf);
@@ -300,128 +468,179 @@ proc_read_info(char *page, char **start,
 }
 
 
-/* 
- * proc file handlers
+/*
+ * /proc handlers
+ * We write our info in page, we begin at offset off and cannot write more
+ * than count bytes. We set eof to 1 if we handle those 2 values. We return the
+ * number of bytes written in page
  */
+
+/* Generic LED functions */
 static int
-proc_read_mled(char *page, char **start, off_t off, int count, int *eof,
-	       void *data)
+read_led(struct asus_hotk *hotk, const char *ledname, int ledmask)
 {
-	int len = 0;
-	struct asus_hotk *hotk = (struct asus_hotk *) data;
-	int led_status = 0;
-	/*
-	 * We use the easy way, we don't care of off and count, so we don't set eof
-	 * to 1
-	 */
-	if (hotk->methods->mled_status) {
-		if (read_acpi_int(NULL, hotk->methods->mled_status, 
-				  &led_status))
-			len =  sprintf(page, "%d\n", led_status);
+	if (ledname) {
+		int led_status;
+
+		if (read_acpi_int(NULL, ledname, &led_status))
+			return led_status;
 		else
-			printk(KERN_WARNING "Asus ACPI: Error reading MLED "
+			printk(KERN_WARNING "Asus ACPI: Error reading LED "
 			       "status\n");
-	} else {
-		len = sprintf(page, "%d\n", (hotk->status & MLED_ON) ? 1 : 0);
 	}
-
-	return len;
+	return (hotk->status & ledmask) ? 1 : 0;
 }
 
 
+/* FIXME: kill extraneous args so it can be called independently */
 static int
-proc_write_mled(struct file *file, const char *buffer,
-		unsigned long count, void *data)
+write_led(const char *buffer, unsigned long count, struct asus_hotk *hotk, 
+          char *ledname, int ledmask, int invert)
 {
 	int value;
 	int led_out = 0;
-	struct asus_hotk *hotk = (struct asus_hotk *) data;
-
-
 
-	/* scan expression.  Multiple expressions may be delimited with ; */
 	if (sscanf(buffer, "%i", &value) == 1)
-		led_out = ~value & 1;
+		led_out = value ? 1 : 0;
 
 	hotk->status =
-	    (value) ? (hotk->status | MLED_ON) : (hotk->status & ~MLED_ON);
-
-	/* We don't have to check mt_mled exists if we are here :) */
-	if (!write_acpi_int(hotk->handle, hotk->methods->mt_mled, led_out,
-			    NULL))
-		printk(KERN_WARNING "Asus ACPI: MLED write failed\n");
+	    (led_out) ? (hotk->status | ledmask) : (hotk->status & ~ledmask);
 
+	if (invert) /* invert target value */
+		led_out = !led_out & 0x1;
 
+	if (!write_acpi_int(hotk->handle, ledname, led_out, NULL))
+		printk(KERN_WARNING "Asus ACPI: LED (%s) write failed\n", ledname);
 
 	return count;
 }
 
+
 /*
- * We write our info in page, we begin at offset off and cannot write more
- * than count bytes. We set eof to 1 if we handle those 2 values. We return the
- * number of bytes written in page
+ * Proc handlers for MLED
  */
 static int
-proc_read_wled(char *page, char **start, off_t off, int count, int *eof,
+proc_read_mled(char *page, char **start, off_t off, int count, int *eof,
 	       void *data)
 {
-	int len = 0;
 	struct asus_hotk *hotk = (struct asus_hotk *) data;
-	int led_status;
+	return sprintf(page, "%d\n", read_led(hotk, hotk->methods->mled_status, MLED_ON));
+}
 
-	if (hotk->methods->wled_status) {
-		if (read_acpi_int(NULL, hotk->methods->wled_status, 
-				  &led_status))
-			len = sprintf(page, "%d\n", led_status);
-		else
-			printk(KERN_WARNING "Asus ACPI: Error reading WLED "
-			       "status\n");
-	} else {
-		len = sprintf(page, "%d\n", (hotk->status & WLED_ON) ? 1 : 0);
-	}
 
-	return len;
+static int
+proc_write_mled(struct file *file, const char *buffer,
+		unsigned long count, void *data)
+{
+	struct asus_hotk *hotk = (struct asus_hotk *) data;
+	return write_led(buffer, count, hotk, hotk->methods->mt_mled, MLED_ON, 1);
+}
+
+/*
+ * Proc handlers for WLED
+ */
+static int
+proc_read_wled(char *page, char **start, off_t off, int count, int *eof,
+	       void *data)
+{
+	struct asus_hotk *hotk = (struct asus_hotk *) data;
+	return sprintf(page, "%d\n", read_led(hotk, hotk->methods->wled_status, WLED_ON));
 }
 
 static int
 proc_write_wled(struct file *file, const char *buffer,
 		unsigned long count, void *data)
 {
-	int value;
-	int led_out = 0;
 	struct asus_hotk *hotk = (struct asus_hotk *) data;
+	return write_led(buffer, count, hotk, hotk->methods->mt_wled, WLED_ON, 0);
+}
 
-	/* scan expression.  Multiple expressions may be delimited with ; */
-	if (sscanf(buffer, "%i", &value) == 1)
-		led_out = value & 1;
-
-	hotk->status =
-	    (value) ? (hotk->status | WLED_ON) : (hotk->status & ~WLED_ON);
-
-	/* We don't have to check if mt_wled exists if we are here :) */
-	if (!write_acpi_int(hotk->handle, hotk->methods->mt_wled, led_out,
-			    NULL))
-		printk(KERN_WARNING "Asus ACPI: WLED write failed\n");
-
+/*
+ * Proc handlers for TLED
+ */
+static int
+proc_read_tled(char *page, char **start, off_t off, int count, int *eof,
+	       void *data)
+{
+	struct asus_hotk *hotk = (struct asus_hotk *) data;
+	return sprintf(page, "%d\n", read_led(hotk, hotk->methods->tled_status, TLED_ON));
+}
 
-	return count;
+static int
+proc_write_tled(struct file *file, const char *buffer,
+		unsigned long count, void *data)
+{
+	struct asus_hotk *hotk = (struct asus_hotk *) data;
+	return write_led(buffer, count, hotk, hotk->methods->mt_tled, TLED_ON, 0);
 }
 
 
+
 static int get_lcd_state(struct asus_hotk *hotk)
 {
 	int lcd = 0;
 
-	/* We don't have to check anything, if we are here */
-	if (!read_acpi_int(NULL, hotk->methods->lcd_status, &lcd))
-		printk(KERN_WARNING "Asus ACPI: Error reading LCD status\n");
+	if (hotk->model != L3H) {
+	/* We don't have to check anything if we are here */
+		if (!read_acpi_int(NULL, hotk->methods->lcd_status, &lcd))
+			printk(KERN_WARNING "Asus ACPI: Error reading LCD status\n");
 	
-	if (hotk->model == L2X)
-		lcd = ~lcd;
+		if (hotk->model == L2D)
+			lcd = ~lcd;
+	} else { /* L3H and the like have to be handled differently */
+		acpi_status status = 0;
+		struct acpi_object_list input;
+		union acpi_object mt_params[2];
+		struct acpi_buffer output;
+		union acpi_object out_obj;
+		
+		input.count = 2;
+		input.pointer = mt_params;
+		/* Note: the following values are partly guessed up, but 
+		   otherwise they seem to work */
+		mt_params[0].type = ACPI_TYPE_INTEGER;
+		mt_params[0].integer.value = 0x02;
+		mt_params[1].type = ACPI_TYPE_INTEGER;
+		mt_params[1].integer.value = 0x02;
+
+		output.length = sizeof(out_obj);
+		output.pointer = &out_obj;
+		
+		status = acpi_evaluate_object(NULL, hotk->methods->lcd_status, &input, &output);
+		if (status != AE_OK)
+			return -1;
+		if (out_obj.type == ACPI_TYPE_INTEGER)
+			/* That's what the AML code does */
+			lcd = out_obj.integer.value >> 8;
+	}
 	
 	return (lcd & 1);
 }
 
+static int set_lcd_state(struct asus_hotk *hotk, int value)
+{
+	int lcd = 0;
+	acpi_status status = 0;
+
+	lcd = value ? 1 : 0;
+	if (lcd != get_lcd_state(hotk)) {
+		/* switch */
+		if (hotk->model != L3H) {
+			status =
+			    acpi_evaluate_object(NULL, hotk->methods->mt_lcd_switch,
+						 NULL, NULL);
+		} else { /* L3H and the like have to be handled differently */
+			if (!write_acpi_int(hotk->handle, hotk->methods->mt_lcd_switch, 0x07, NULL))
+				status = AE_ERROR;
+			/* L3H's AML executes EHK (0x07) upon Fn+F7 keypress, 
+			   the exact behaviour is simulated here */
+		}
+		if (ACPI_FAILURE(status))
+			printk(KERN_WARNING "Asus ACPI: Error switching LCD\n");
+	}
+	return 0;
+
+}
 
 static int
 proc_read_lcd(char *page, char **start, off_t off, int count, int *eof,
@@ -436,26 +655,10 @@ proc_write_lcd(struct file *file, const 
 	       unsigned long count, void *data)
 {
 	int value;
-	int lcd = 0;
-	acpi_status status = 0;
-	int lcd_status = 0;
 	struct asus_hotk *hotk = (struct asus_hotk *) data;
-
-	/* scan expression.  Multiple expressions may be delimited with ; */
+	
 	if (sscanf(buffer, "%i", &value) == 1)
-		lcd = value & 1;
-
-	lcd_status = get_lcd_state(hotk);
-
-	if (lcd_status != lcd) {
-		/* switch */
-		status =
-		    acpi_evaluate_object(NULL, hotk->methods->mt_lcd_switch,
-					 NULL, NULL);
-		if (ACPI_FAILURE(status))
-			printk(KERN_WARNING "Asus ACPI: Error switching LCD\n");
-	}
-
+		set_lcd_state(hotk, value);
 	return count;
 }
 
@@ -521,7 +724,6 @@ proc_write_brn(struct file *file, const 
 	int value;
 	struct asus_hotk *hotk = (struct asus_hotk *) data;
 
-	/* scan expression.  Multiple expressions may be delimited with ; */
 	if (sscanf(buffer, "%d", &value) == 1) {
 		value = (0 < value) ? ((15 < value) ? 15 : value) : 0;
 			/* 0 <= value <= 15 */
@@ -546,7 +748,6 @@ static void set_display(int value, struc
  * Now, *this* one could be more user-friendly, but so far, no-one has 
  * complained. The significance of bits is the same as in proc_write_disp()
  */
-
 static int
 proc_read_disp(char *page, char **start, off_t off, int count, int *eof,
 	      void *data)
@@ -560,12 +761,11 @@ proc_read_disp(char *page, char **start,
 }
 
 /*
- * Experimental support for display switching. As of now: 0x01 should activate 
- * the LCD output, 0x02 should do for CRT, and 0x04 for TV-Out. Any combination 
+ * Experimental support for display switching. As of now: 1 should activate 
+ * the LCD output, 2 should do for CRT, and 4 for TV-Out. Any combination 
  * (bitwise) of these will suffice. I never actually tested 3 displays hooked up 
- * simultaneously, so be warned.
+ * simultaneously, so be warned. See the acpi4asus README for more info.
  */
-
 static int
 proc_write_disp(struct file *file, const char *buffer,
 	       unsigned long count, void *data)
@@ -573,7 +773,6 @@ proc_write_disp(struct file *file, const
 	int value;
 	struct asus_hotk *hotk = (struct asus_hotk *) data;
 
-	/* scan expression.  Multiple expressions may be delimited with ; */
 	if (sscanf(buffer, "%d", &value) == 1)
 		set_display(value, hotk);
 	else {
@@ -583,6 +782,31 @@ proc_write_disp(struct file *file, const
 	return count;
 }
 
+
+typedef int (proc_readfunc)(char *page, char **start, off_t off, int count,
+	                     int *eof, void *data);
+typedef int (proc_writefunc)(struct file *file, const char *buffer,
+	                      unsigned long count, void *data);
+
+static int
+__init asus_proc_add(char *name, proc_writefunc *writefunc,
+	             proc_readfunc *readfunc, mode_t mode,
+	             struct acpi_device *device)
+{
+	struct proc_dir_entry *proc = create_proc_entry(name, mode, acpi_device_dir(device));
+	if(!proc) {
+		printk(KERN_WARNING "  Unable to create %s fs entry\n", name);
+		return -1;
+	}
+	proc->write_proc = writefunc;
+	proc->read_proc = readfunc;
+	proc->data = acpi_driver_data(device);
+	proc->owner = THIS_MODULE;
+	proc->uid = asus_uid;
+	proc->gid = asus_gid;
+	return 0;
+}
+
 static int __init asus_hotk_add_fs(struct acpi_device *device)
 {
 	struct proc_dir_entry *proc;
@@ -605,46 +829,28 @@ static int __init asus_hotk_add_fs(struc
 	if (!acpi_device_dir(device))
 		return(-ENODEV);
 
-	proc = create_proc_entry(PROC_INFOS, mode, acpi_device_dir(device));
+	proc = create_proc_entry(PROC_INFO, mode, acpi_device_dir(device));
 	if (proc) {
 		proc->read_proc = proc_read_info;
 		proc->data = acpi_driver_data(device);
 		proc->owner = THIS_MODULE;
 		proc->uid = asus_uid;
-		proc->gid = asus_gid;;
+		proc->gid = asus_gid;
 	} else {
-		printk(KERN_WARNING "  Unable to create " PROC_INFOS
+		printk(KERN_WARNING "  Unable to create " PROC_INFO
 		       " fs entry\n");
 	}
 
 	if (hotk->methods->mt_wled) {
-		proc = create_proc_entry(PROC_WLED, mode, acpi_device_dir(device));
-		if (proc) {
-			proc->write_proc = proc_write_wled;
-			proc->read_proc = proc_read_wled;
-			proc->data = acpi_driver_data(device);
-			proc->owner = THIS_MODULE;
-			proc->uid = asus_uid;
-			proc->gid = asus_gid;;
-		} else {
-			printk(KERN_WARNING "  Unable to create " PROC_WLED
-			       " fs entry\n");
-		}
+		asus_proc_add(PROC_WLED, &proc_write_wled, &proc_read_wled, mode, device);
 	}
 
 	if (hotk->methods->mt_mled) {
-		proc = create_proc_entry(PROC_MLED, mode, acpi_device_dir(device));
-		if (proc) {
-			proc->write_proc = proc_write_mled;
-			proc->read_proc = proc_read_mled;
-			proc->data = acpi_driver_data(device);
-			proc->owner = THIS_MODULE;
-			proc->uid = asus_uid;
-			proc->gid = asus_gid;;
-		} else {
-			printk(KERN_WARNING "  Unable to create " PROC_MLED
-			       " fs entry\n");
-		}
+		asus_proc_add(PROC_MLED, &proc_write_mled, &proc_read_mled, mode, device);
+	}
+
+	if (hotk->methods->mt_tled) {
+		asus_proc_add(PROC_TLED, &proc_write_tled, &proc_read_tled, mode, device);
 	}
 
 	/* 
@@ -652,49 +858,17 @@ static int __init asus_hotk_add_fs(struc
 	 * from keyboard 
 	 */
 	if (hotk->methods->mt_lcd_switch && hotk->methods->lcd_status) {
-		proc = create_proc_entry(PROC_LCD, mode, acpi_device_dir(device));
-		if (proc) {
-			proc->write_proc = proc_write_lcd;
-			proc->read_proc = proc_read_lcd;
-			proc->data = acpi_driver_data(device);
-			proc->owner = THIS_MODULE;
-			proc->uid = asus_uid;
-			proc->gid = asus_gid;;
-		} else {
-			printk(KERN_WARNING "  Unable to create " PROC_LCD
-			       " fs entry\n");
-		}
+		asus_proc_add(PROC_LCD, &proc_write_lcd, &proc_read_lcd, mode, device);
 	}
 	
 	if ((hotk->methods->brightness_up && hotk->methods->brightness_down) ||
 	    (hotk->methods->brightness_get && hotk->methods->brightness_get)) {
-		proc = create_proc_entry(PROC_BRN, mode, acpi_device_dir(device));
-		if (proc) {
-			proc->write_proc = proc_write_brn;
-			proc->read_proc = proc_read_brn;
-			proc->data = acpi_driver_data(device);
-			proc->owner = THIS_MODULE;
-			proc->uid = asus_uid;
-			proc->gid = asus_gid;;
-		} else {
-			printk(KERN_WARNING "  Unable to create " PROC_BRN
-			       " fs entry\n");
-		}
+		asus_proc_add(PROC_BRN, &proc_write_brn, &proc_read_brn, mode, device);
 	}
 
 	if (hotk->methods->display_set) {
-		proc = create_proc_entry(PROC_DISP, mode, acpi_device_dir(device));
-		if (proc) {
-			proc->write_proc = proc_write_disp;
-			proc->read_proc = proc_read_disp;
-			proc->data = acpi_driver_data(device);
-			proc->owner = THIS_MODULE;
-			proc->uid = asus_uid;
-			proc->gid = asus_gid;;
-		} else {
-			printk(KERN_WARNING "  Unable to create " PROC_DISP
-			       " fs entry\n");
-		}
+		asus_proc_add(PROC_DISP, &proc_write_disp, &proc_read_disp, mode, device);
+
 	}
 
 	return 0;
@@ -761,11 +935,6 @@ static int __init asus_hotk_get_info(str
 	else if (bsts_result)
 		printk(KERN_NOTICE "  BSTS called, 0x%02x returned\n", bsts_result);
 
-	/*
-	 * Here, we also use asus_info to make decision. For example, on INIT
-	 * method, S1X and L1X models both reports to be L84F, but they don't
-	 * have the same methods (L1X has WLED, S1X don't)
-	 */
 	model = (union acpi_object *) buffer.pointer;
 	if (model->type == ACPI_TYPE_STRING) {
 		printk(KERN_NOTICE "  %s model detected, ", model->string.pointer);
@@ -774,52 +943,63 @@ static int __init asus_hotk_get_info(str
 	hotk->model = END_MODEL;
 	if (strncmp(model->string.pointer, "L3D", 3) == 0)
 		hotk->model = L3D;
-		/*
-		 * L2B has same settings that L3X, except for GL32, but as
-		 * there is no node to get the LCD status, and as GL32 is never
-		 * used anywhere else, I assume it's safe, even if lcd get is
-		 * broken for this model (TODO fix it ?)
-		 */
+	else if (strncmp(model->string.pointer, "L3H", 3) == 0 ||
+		 strncmp(model->string.pointer, "L2E", 3) == 0)
+		hotk->model = L3H;
 	else if (strncmp(model->string.pointer, "L3", 2) == 0 ||
 		 strncmp(model->string.pointer, "L2B", 3) == 0)
-		hotk->model = L3X;
+		hotk->model = L3C;
+	else if (strncmp(model->string.pointer, "L8L", 3) == 0)
+		hotk->model = L8L;
+	else if (strncmp(model->string.pointer, "M2N", 3) == 0 ||
+		 strncmp(model->string.pointer, "M3N", 3) == 0 ||
+		 strncmp(model->string.pointer, "S1N", 3) == 0 ||
+		 strncmp(model->string.pointer, "S5N", 3) == 0)
+		hotk->model = xxN;
+	else if (strncmp(model->string.pointer, "M1", 2) == 0)
+		hotk->model = M1A;
 	else if (strncmp(model->string.pointer, "M2", 2) == 0)
-		hotk->model = M2X;
-	else if (strncmp(model->string.pointer, "M3N", 3) == 0 ||
-		 strncmp(model->string.pointer, "S1N", 3) == 0)
-		hotk->model = M3N; /* S1300N is similar enough */
+		hotk->model = M2E;
 	else if (strncmp(model->string.pointer, "L2", 2) == 0)
-		hotk->model = L2X;
-	else if (strncmp(model->string.pointer, "L8", 2) == 0) {
-		/* S1300A reports L84F, but L1400B too */
-		if (asus_info) {
-			if (strncmp(asus_info->oem_table_id, "L1", 2) == 0)
-				hotk->model = L1X;
-		} else
-			hotk->model = S1X;
-	}
+		hotk->model = L2D;
+	else if (strncmp(model->string.pointer, "L8", 2) == 0)
+		hotk->model = S1x;
 	else if (strncmp(model->string.pointer, "D1", 2) == 0)
-		hotk->model = D1X;
+		hotk->model = D1x;
 	else if (strncmp(model->string.pointer, "A1", 2) == 0)
-		hotk->model = A1X;
+		hotk->model = A1x;
 	else if (strncmp(model->string.pointer, "A2", 2) == 0)
-		hotk->model = A2X;
+		hotk->model = A2x;
 	else if (strncmp(model->string.pointer, "J1", 2) == 0)
-		hotk->model = S2X;
+		hotk->model = S2x;
 	else if (strncmp(model->string.pointer, "L5", 2) == 0)
-		hotk->model = L5X;
+		hotk->model = L5x;
 
 	if (hotk->model == END_MODEL) {
 		/* By default use the same values, as I don't know others */
 		printk("unsupported, trying default values, supply the "
 		       "developers with your DSDT\n");
-		hotk->model = L2X;
+		hotk->model = M2E;
 	} else {
 		printk("supported\n");
 	}
 
 	hotk->methods = &model_conf[hotk->model];
 
+	/* Sort of per-model blacklist */
+	if (strncmp(model->string.pointer, "L2B", 3) == 0)
+		hotk->methods->lcd_status = NULL; 
+	/* L2B is similar enough to L3C to use its settings, with this only 
+	   exception */
+	else if (strncmp(model->string.pointer, "S5N", 3) == 0)
+		hotk->methods->mt_mled = NULL; 
+	/* S5N has no MLED */
+	else if (asus_info) {
+		if (strncmp(asus_info->oem_table_id, "L1", 2) == 0)
+			hotk->methods->mled_status = NULL;
+	/* S1300A reports L84F, but L1400B too, account for that */
+	}
+
 	acpi_os_free(model);
 
 	return AE_OK;
@@ -917,8 +1097,6 @@ static int __init asus_hotk_add(struct a
 }
 
 
-
-
 static int asus_hotk_remove(struct acpi_device *device, int type)
 {
 	acpi_status status = 0;
@@ -940,15 +1118,13 @@ static int asus_hotk_remove(struct acpi_
 }
 
 
-
-
 static int __init asus_acpi_init(void)
 {
 	int result;
 
 	asus_proc_dir = proc_mkdir(PROC_ASUS, acpi_root_dir);
 	if (!asus_proc_dir) {
-		printk(KERN_ERR "Asus ACPI: Unable to create /proc entry");
+		printk(KERN_ERR "Asus ACPI: Unable to create /proc entry\n");
 		return(-ENODEV);
 	}
 	asus_proc_dir->owner = THIS_MODULE;
@@ -963,7 +1139,6 @@ static int __init asus_acpi_init(void)
 }
 
 
-
 static void __exit asus_acpi_exit(void)
 {
 	acpi_bus_unregister_driver(&asus_hotk_driver);

--AhhlLboLdkugWU4S--


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
