From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: [ANNOUNCE] acpi4asus 0.25 released
Date: Sat, 23 Aug 2003 19:33:27 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030823173327.GA31453@hell.org.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="uQr8t48UFsdbeI+V"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline

Hi,
Andrew, please apply the attached patches (also on the web):
http://hell.org.pl/~sziwan/asus/acpi4asus-0.24a-0.25-2.4.diff [for 2.4]
http://hell.org.pl/~sziwan/asus/acpi4asus-0.24a-0.25-2.6.0-test.diff [for 2.6]

ChangeLog says:
Version 0.25
        Various fixes
        Added support for A2500H (thanks to Ricardo Cerqueira)
        Added support for M3700N and S1300N
        Work around duplicate error message

Note: The CVS is up-to-date, the sourceforge official release will appear
soon.

Best regards, TIA,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org

--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: attachment; filename="acpi4asus-0.24a-0.25-2.4.diff"

--- a/drivers/acpi/asus_acpi.c	2003-07-12 16:08:34.000000000 +0200
+++ b/drivers/acpi/asus_acpi.c	2003-08-23 18:55:19.000000000 +0200
@@ -26,13 +26,21 @@
  *  Johann Wiesner - Small compile fixes
  *  John Belmonte  - ACPI code for Toshiba laptop was a good starting point.
  *
- *  TODO
+ *  TODO:
  *  add Fn key status
- *  Add mode selection on module loading (parameter) -> still necessary ?
+ *  Add mode selection on module loading (parameter) -> still necessary?
  *  Complete display switching -- may require dirty hacks?
+ *  Complete support for Centrino laptops
+ *  Reading certain fields (e.g. \SG66 in A2500H) consistently fails, while 
+ *    reading others (\BAOF, the same machine) succeeds. Why?
  *
  */
 
+#include <linux/config.h>
+#if defined (CONFIG_MODVERSIONS) && !defined (MODVERSIONS) && defined (MODULE)
+#include <linux/modversions.h>
+#endif
+
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -41,7 +49,7 @@
 #include <acpi/acpi_drivers.h>
 #include <acpi/acpi_bus.h>
 
-#define ASUS_ACPI_VERSION "0.24a"
+#define ASUS_ACPI_VERSION "0.25"
 
 #define PROC_ASUS       "asus"	//the directory
 #define PROC_MLED       "mled"
@@ -111,20 +119,22 @@
 	struct model_data *methods;	//methods available on the laptop
 	u8 brightness;			//brighness level
 	enum {
-		L2X = 0,	//L200D -> TODO check Q11 (Fn+F8)
-				//	   Calling this method simply hang the
+		A1X=0,  	//A1340D, A1300F
+		A2X,		//A2500H
+		D1X,		//D1
+		L1X,		//L1400B
+		L2X,		//L200D -> TODO check Q11 (Fn+F8)
+				//	   Calling this method simply hangs the
 				//	   computer, ISMI method hangs the laptop.
-		L3X,		//L3C
 		L3D,		//L3400D
+		L3X,		//L3C
 		M2X,		//M2400E
+		M3N,		//M3700N, but also S1300N -> TODO WLED
 		S1X,		//S1300A -> TODO special keys do not work ?
-		D1X,		//D1
-		L1X,		//L1400B
-		A1X, 		//A1340D, A1300F
-		J1X,		//S200 (J1)
+		S2X,		//S200 (J1 reported), Victor MP-XP7210
 				//TODO  A1370D does not seems to have a ATK device 
 				//	L8400 model doesn't have ATK
-		END_MODEL,
+		END_MODEL
 	} model;		//Models currently supported
 	u16 event_count[128];	//count for each event TODO make this better
 };
@@ -134,7 +144,8 @@
 #define S1X_PREFIX "\\_SB.PCI0.PX40."
 #define L1X_PREFIX S1X_PREFIX
 #define A1X_PREFIX "\\_SB.PCI0.ISA.EC0."
-#define J1X_PREFIX A1X_PREFIX
+#define S2X_PREFIX A1X_PREFIX
+#define M3N_PREFIX "\\_SB.PCI0.SBRG.EC0."
 
 static struct model_data model_conf[END_MODEL] = {
         /*
@@ -148,33 +159,40 @@
 	 * it seems to be a kind of switch, but what for ?
 	 *
 	 */
+	{"A1X", "MLED", "\\MAIL", NULL, NULL, A1X_PREFIX "_Q10", "\\BKLI",
+	 A1X_PREFIX "_Q0E", A1X_PREFIX "_Q0F", NULL, NULL, NULL, NULL, NULL},
+
+	{"A2X", "MLED", NULL, "WLED", "\\SG66", "\\Q10", "\\BAOF",
+	 "\\Q0E", "\\Q0F", "SPLV", "GPLV", "\\CMOD", "SDSP", "\\INFB"},
+
+	{"D1X", "MLED", NULL, NULL, NULL, "\\Q0D", "\\GP11", 
+	 "\\Q0C", "\\Q0B", NULL, NULL, "\\BLVL", "SDSP","\\INFB"},
+
+	{"L1X", "MLED", NULL, "WLED", NULL, L1X_PREFIX "Q10", "\\PNOF", 
+	 L1X_PREFIX "Q0F", L1X_PREFIX "Q0E", "SPLV", "GPLV", "\\BRIT", NULL, NULL},
+	 
 	{"L2X", "MLED", "\\SGP6", "WLED", "\\RCP3", "\\Q10", "\\SGP0", 
 	 "\\Q0E", "\\Q0F", NULL, NULL, NULL, "SDSP", "\\INFB"},
 
+	{"L3D", "MLED", "\\MALD", "WLED", NULL, "\\Q10", "\\BKLG",
+	 "\\Q0E", "\\Q0F", "SPLV", "GPLV", "\\BLVL", "SDSP", "\\INFB"},
+
 	{"L3X", "MLED", NULL, "WLED", NULL, L3X_PREFIX "_Q10", "\\GL32", 
 	 L3X_PREFIX "_Q0F", L3X_PREFIX "_Q0E", "SPLV", "GPLV", "\\BLVL", "SDSP", 
 	 "\\_SB.PCI0.PCI1.VGAC.NMAP"},
 
-	{"L3D", "MLED", "\\MALD", "WLED", NULL, "\\Q10", "\\BKLG",
-	 "\\Q0E", "\\Q0F", "SPLV", "GPLV", "\\BLVL", "SDSP", "\\INFB"},
-
 	{"M2X", "MLED", NULL, "WLED", NULL, "\\Q10", "\\GP06", 
 	 "\\Q0E","\\Q0F", "SPLV", "GPLV", NULL, "SDSP", "\\INFB"},
+
+	{"M3N", "MLED", NULL, "WLED", "\\PO33", M3N_PREFIX "_Q10", "\\BKLT", 
+	 M3N_PREFIX "_Q0F", M3N_PREFIX "_Q0E", "SPLV", "GPLV", "\\LBTN", "SDSP", 
+	 "\\ADVG"},
 	
 	{"S1X", "MLED", "\\EMLE", "WLED", NULL, S1X_PREFIX "Q10", "\\PNOF", 
 	 S1X_PREFIX "Q0F", S1X_PREFIX "Q0E", "SPLV", "GPLV", "\\BRIT", NULL, NULL},
 	
-	{"D1X", "MLED", NULL, NULL, NULL, "\\Q0D", "\\GP11", 
-	 "\\Q0C", "\\Q0B", NULL, NULL, "\\BLVL", "SDSP","\\INFB"},
-
-	{"L1X", "MLED", NULL, "WLED", NULL, L1X_PREFIX "Q10", "\\PNOF", 
-	 L1X_PREFIX "Q0F", L1X_PREFIX "Q0E", "SPLV", "GPLV", "\\BRIT", NULL, NULL},
-
-	{"A1X", "MLED", "\\MAIL", NULL, NULL, A1X_PREFIX "_Q10", "\\BKLI",
-	 A1X_PREFIX "_Q0E", A1X_PREFIX "_Q0F", NULL, NULL, NULL, NULL, NULL},
-
-	{"J1X", "MLED", "\\MAIL", NULL, NULL, J1X_PREFIX "_Q10", "\\BKLI",
-	 J1X_PREFIX "_Q0B", J1X_PREFIX "_Q0A", NULL, NULL, NULL, NULL, NULL}
+	{"S2X", "MLED", "\\MAIL", NULL, NULL, S2X_PREFIX "_Q10", "\\BKLI",
+	 S2X_PREFIX "_Q0B", S2X_PREFIX "_Q0A", NULL, NULL, NULL, NULL, NULL}
 };
 
 /* procdir we use */
@@ -235,7 +253,7 @@
 	output.length = sizeof(out_obj);
 	output.pointer = &out_obj;
 
-	status = acpi_evaluate_object(handle, (char*) method, NULL, &output);
+	status = acpi_evaluate_object(handle, (char *) method, NULL, &output);
 	*val = out_obj.integer.value;
 	return (status == AE_OK) && (out_obj.type == ACPI_TYPE_INTEGER);
 }
@@ -453,7 +471,7 @@
 {
 	acpi_status status = 0;
 
-	/* ATKD laptop */
+	/* SPLV laptop */
 	if(hotk->methods->brightness_set) {
 		if (!write_acpi_int(hotk->handle, hotk->methods->brightness_set, 
 				    value, NULL))
@@ -461,7 +479,7 @@
 		return;
 	}
 
-	/* HOTK laptop if we are here, act as appropriate */
+	/* No SPLV method if we are here, act as appropriate */
 	value -= hotk->brightness;
 	while (value != 0) {
 		status = acpi_evaluate_object(NULL, (value > 0) ? 
@@ -479,7 +497,7 @@
 {
 	int value;
 	
-	if(hotk->methods->brightness_get) { /* ATKD laptop */
+	if(hotk->methods->brightness_get) { /* SPLV/GPLV laptop */
 		if (!read_acpi_int(hotk->handle, hotk->methods->brightness_get, 
 				   &value))
 			printk(KERN_NOTICE "Asus ACPI: Error reading brightness\n");
@@ -487,7 +505,7 @@
 		if (!read_acpi_int(NULL, hotk->methods->brightness_status, 
 				   &value))
 			printk(KERN_NOTICE "Asus ACPI: Error reading brightness\n");
-	} else /* HOTK laptop */
+	} else /* No GPLV method */
 		value = hotk->brightness;
 	return value;
 }
@@ -546,7 +564,7 @@
 }
 
 /*
- * Preliminary support for display switching. As of now: 0x01 should activate 
+ * Experimental support for display switching. As of now: 0x01 should activate 
  * the LCD output, 0x02 should do for CRT, and 0x04 for TV-Out. Any combination 
  * (bitwise) of these will suffice. I never actually tested 3 displays hooked up 
  * simultaneously, so be warned.
@@ -690,7 +708,7 @@
 static void asus_hotk_notify(acpi_handle handle, u32 event, void *data)
 {
 	/* TODO Find a better way to handle events count. Here, in data, we receive
-	 * the hotk, so we can make anything !!
+	 * the hotk, so we can do anything!
 	 */
 	struct asus_hotk *hotk = (struct asus_hotk *) data;
 
@@ -750,6 +768,9 @@
 		hotk->model = L3X;
 	else if (strncmp(model->string.pointer, "M2", 2) == 0)
 		hotk->model = M2X;
+	else if (strncmp(model->string.pointer, "M3N", 3) == 0 ||
+		 strncmp(model->string.pointer, "S1N", 3) == 0)
+		hotk->model = M3N; /* S1300N is similar enough */
 	else if (strncmp(model->string.pointer, "L2", 2) == 0)
 		hotk->model = L2X;
 	else if (strncmp(model->string.pointer, "L8", 2) == 0)
@@ -762,8 +783,10 @@
 		hotk->model = D1X;
 	else if (strncmp(model->string.pointer, "A1", 2) == 0)
 		hotk->model = A1X;
+	else if (strncmp(model->string.pointer, "A2", 2) == 0)
+		hotk->model = A2X;
 	else if (strncmp(model->string.pointer, "J1", 2) == 0)
-		hotk->model = J1X;
+		hotk->model = S2X;
 
 
 	if (hotk->model == END_MODEL) {
@@ -851,17 +874,20 @@
 		       "  Notify Handler installed successfully\n");
 	}
 
-	/* For HOTK laptops: init the hotk->brightness value */
+	/* For laptops without GPLV: init the hotk->brightness value */
 	if ((!hotk->methods->brightness_get) && (!hotk->methods->brightness_status) &&
 	    (hotk->methods->brightness_up && hotk->methods->brightness_down)) {
 		status = acpi_evaluate_object(NULL, hotk->methods->brightness_down,
 					      NULL, NULL);
 		if (ACPI_FAILURE(status))
 			printk(KERN_NOTICE "  Error changing brightness\n");
-		status = acpi_evaluate_object(NULL, hotk->methods->brightness_up,
-					      NULL, NULL);
-		if (ACPI_FAILURE(status))
-			printk(KERN_NOTICE "  Error changing brightness\n");
+		else {
+			status = acpi_evaluate_object(NULL, hotk->methods->brightness_up,
+						      NULL, NULL);
+			if (ACPI_FAILURE(status))
+				printk(KERN_NOTICE "  Strange, error changing" 
+				       " brightness\n");
+		}
 	}
 
       end:
--- a/Documentation/Configure.help	2003-08-02 23:38:56.000000000 +0200
+++ b/Documentation/Configure.help	2003-08-23 19:04:46.000000000 +0200
@@ -18853,6 +18853,9 @@
   display brightness and output, switching the LCD backlight on and off,
   and most importantly, allows you to blink those fancy LEDs intended
   for reporting mail and wireless status.
+
+  Note: the display switching code is currently considered EXPERIMENTAL,
+  toying with these values may even lock your machine.
   
   All settings are changed via /proc/acpi/asus directory entries. Owner
   and group for these entries can be set with asus_uid and asus_gid

--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: attachment; filename="acpi4asus-0.24a-0.25-2.6.0-test.diff"

--- a/drivers/acpi/asus_acpi.c	2003-07-12 16:08:34.000000000 +0200
+++ b/drivers/acpi/asus_acpi.c	2003-08-23 18:55:19.000000000 +0200
@@ -26,13 +26,21 @@
  *  Johann Wiesner - Small compile fixes
  *  John Belmonte  - ACPI code for Toshiba laptop was a good starting point.
  *
- *  TODO
+ *  TODO:
  *  add Fn key status
- *  Add mode selection on module loading (parameter) -> still necessary ?
+ *  Add mode selection on module loading (parameter) -> still necessary?
  *  Complete display switching -- may require dirty hacks?
+ *  Complete support for Centrino laptops
+ *  Reading certain fields (e.g. \SG66 in A2500H) consistently fails, while 
+ *    reading others (\BAOF, the same machine) succeeds. Why?
  *
  */
 
+#include <linux/config.h>
+#if defined (CONFIG_MODVERSIONS) && !defined (MODVERSIONS) && defined (MODULE)
+#include <linux/modversions.h>
+#endif
+
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -41,7 +49,7 @@
 #include <acpi/acpi_drivers.h>
 #include <acpi/acpi_bus.h>
 
-#define ASUS_ACPI_VERSION "0.24a"
+#define ASUS_ACPI_VERSION "0.25"
 
 #define PROC_ASUS       "asus"	//the directory
 #define PROC_MLED       "mled"
@@ -110,20 +118,22 @@
 	struct model_data *methods;	//methods available on the laptop
 	u8 brightness;			//brighness level
 	enum {
-		L2X = 0,	//L200D -> TODO check Q11 (Fn+F8)
-				//	   Calling this method simply hang the
+		A1X=0,  	//A1340D, A1300F
+		A2X,		//A2500H
+		D1X,		//D1
+		L1X,		//L1400B
+		L2X,		//L200D -> TODO check Q11 (Fn+F8)
+				//	   Calling this method simply hangs the
 				//	   computer, ISMI method hangs the laptop.
-		L3X,		//L3C
 		L3D,		//L3400D
+		L3X,		//L3C
 		M2X,		//M2400E
+		M3N,		//M3700N, but also S1300N -> TODO WLED
 		S1X,		//S1300A -> TODO special keys do not work ?
-		D1X,		//D1
-		L1X,		//L1400B
-		A1X, 		//A1340D, A1300F
-		J1X,		//S200 (J1)
+		S2X,		//S200 (J1 reported), Victor MP-XP7210
 				//TODO  A1370D does not seems to have a ATK device 
 				//	L8400 model doesn't have ATK
-		END_MODEL,
+		END_MODEL
 	} model;		//Models currently supported
 	u16 event_count[128];	//count for each event TODO make this better
 };
@@ -133,7 +143,8 @@
 #define S1X_PREFIX "\\_SB.PCI0.PX40."
 #define L1X_PREFIX S1X_PREFIX
 #define A1X_PREFIX "\\_SB.PCI0.ISA.EC0."
-#define J1X_PREFIX A1X_PREFIX
+#define S2X_PREFIX A1X_PREFIX
+#define M3N_PREFIX "\\_SB.PCI0.SBRG.EC0."
 
 static struct model_data model_conf[END_MODEL] = {
         /*
@@ -147,33 +158,40 @@
 	 * it seems to be a kind of switch, but what for ?
 	 *
 	 */
+	{"A1X", "MLED", "\\MAIL", NULL, NULL, A1X_PREFIX "_Q10", "\\BKLI",
+	 A1X_PREFIX "_Q0E", A1X_PREFIX "_Q0F", NULL, NULL, NULL, NULL, NULL},
+
+	{"A2X", "MLED", NULL, "WLED", "\\SG66", "\\Q10", "\\BAOF",
+	 "\\Q0E", "\\Q0F", "SPLV", "GPLV", "\\CMOD", "SDSP", "\\INFB"},
+
+	{"D1X", "MLED", NULL, NULL, NULL, "\\Q0D", "\\GP11", 
+	 "\\Q0C", "\\Q0B", NULL, NULL, "\\BLVL", "SDSP","\\INFB"},
+
+	{"L1X", "MLED", NULL, "WLED", NULL, L1X_PREFIX "Q10", "\\PNOF", 
+	 L1X_PREFIX "Q0F", L1X_PREFIX "Q0E", "SPLV", "GPLV", "\\BRIT", NULL, NULL},
+	 
 	{"L2X", "MLED", "\\SGP6", "WLED", "\\RCP3", "\\Q10", "\\SGP0", 
 	 "\\Q0E", "\\Q0F", NULL, NULL, NULL, "SDSP", "\\INFB"},
 
+	{"L3D", "MLED", "\\MALD", "WLED", NULL, "\\Q10", "\\BKLG",
+	 "\\Q0E", "\\Q0F", "SPLV", "GPLV", "\\BLVL", "SDSP", "\\INFB"},
+
 	{"L3X", "MLED", NULL, "WLED", NULL, L3X_PREFIX "_Q10", "\\GL32", 
 	 L3X_PREFIX "_Q0F", L3X_PREFIX "_Q0E", "SPLV", "GPLV", "\\BLVL", "SDSP", 
 	 "\\_SB.PCI0.PCI1.VGAC.NMAP"},
 
-	{"L3D", "MLED", "\\MALD", "WLED", NULL, "\\Q10", "\\BKLG",
-	 "\\Q0E", "\\Q0F", "SPLV", "GPLV", "\\BLVL", "SDSP", "\\INFB"},
-
 	{"M2X", "MLED", NULL, "WLED", NULL, "\\Q10", "\\GP06", 
 	 "\\Q0E","\\Q0F", "SPLV", "GPLV", NULL, "SDSP", "\\INFB"},
+
+	{"M3N", "MLED", NULL, "WLED", "\\PO33", M3N_PREFIX "_Q10", "\\BKLT", 
+	 M3N_PREFIX "_Q0F", M3N_PREFIX "_Q0E", "SPLV", "GPLV", "\\LBTN", "SDSP", 
+	 "\\ADVG"},
 	
 	{"S1X", "MLED", "\\EMLE", "WLED", NULL, S1X_PREFIX "Q10", "\\PNOF", 
 	 S1X_PREFIX "Q0F", S1X_PREFIX "Q0E", "SPLV", "GPLV", "\\BRIT", NULL, NULL},
 	
-	{"D1X", "MLED", NULL, NULL, NULL, "\\Q0D", "\\GP11", 
-	 "\\Q0C", "\\Q0B", NULL, NULL, "\\BLVL", "SDSP","\\INFB"},
-
-	{"L1X", "MLED", NULL, "WLED", NULL, L1X_PREFIX "Q10", "\\PNOF", 
-	 L1X_PREFIX "Q0F", L1X_PREFIX "Q0E", "SPLV", "GPLV", "\\BRIT", NULL, NULL},
-
-	{"A1X", "MLED", "\\MAIL", NULL, NULL, A1X_PREFIX "_Q10", "\\BKLI",
-	 A1X_PREFIX "_Q0E", A1X_PREFIX "_Q0F", NULL, NULL, NULL, NULL, NULL},
-
-	{"J1X", "MLED", "\\MAIL", NULL, NULL, J1X_PREFIX "_Q10", "\\BKLI",
-	 J1X_PREFIX "_Q0B", J1X_PREFIX "_Q0A", NULL, NULL, NULL, NULL, NULL}
+	{"S2X", "MLED", "\\MAIL", NULL, NULL, S2X_PREFIX "_Q10", "\\BKLI",
+	 S2X_PREFIX "_Q0B", S2X_PREFIX "_Q0A", NULL, NULL, NULL, NULL, NULL}
 };
 
 /* procdir we use */
@@ -234,7 +252,7 @@
 	output.length = sizeof(out_obj);
 	output.pointer = &out_obj;
 
-	status = acpi_evaluate_object(handle, (char*) method, NULL, &output);
+	status = acpi_evaluate_object(handle, (char *) method, NULL, &output);
 	*val = out_obj.integer.value;
 	return (status == AE_OK) && (out_obj.type == ACPI_TYPE_INTEGER);
 }
@@ -452,7 +470,7 @@
 {
 	acpi_status status = 0;
 
-	/* ATKD laptop */
+	/* SPLV laptop */
 	if(hotk->methods->brightness_set) {
 		if (!write_acpi_int(hotk->handle, hotk->methods->brightness_set, 
 				    value, NULL))
@@ -460,7 +478,7 @@
 		return;
 	}
 
-	/* HOTK laptop if we are here, act as appropriate */
+	/* No SPLV method if we are here, act as appropriate */
 	value -= hotk->brightness;
 	while (value != 0) {
 		status = acpi_evaluate_object(NULL, (value > 0) ? 
@@ -478,7 +496,7 @@
 {
 	int value;
 	
-	if(hotk->methods->brightness_get) { /* ATKD laptop */
+	if(hotk->methods->brightness_get) { /* SPLV/GPLV laptop */
 		if (!read_acpi_int(hotk->handle, hotk->methods->brightness_get, 
 				   &value))
 			printk(KERN_NOTICE "Asus ACPI: Error reading brightness\n");
@@ -486,7 +504,7 @@
 		if (!read_acpi_int(NULL, hotk->methods->brightness_status, 
 				   &value))
 			printk(KERN_NOTICE "Asus ACPI: Error reading brightness\n");
-	} else /* HOTK laptop */
+	} else /* No GPLV method */
 		value = hotk->brightness;
 	return value;
 }
@@ -545,7 +563,7 @@
 }
 
 /*
- * Preliminary support for display switching. As of now: 0x01 should activate 
+ * Experimental support for display switching. As of now: 0x01 should activate 
  * the LCD output, 0x02 should do for CRT, and 0x04 for TV-Out. Any combination 
  * (bitwise) of these will suffice. I never actually tested 3 displays hooked up 
  * simultaneously, so be warned.
@@ -689,7 +707,7 @@
 static void asus_hotk_notify(acpi_handle handle, u32 event, void *data)
 {
 	/* TODO Find a better way to handle events count. Here, in data, we receive
-	 * the hotk, so we can make anything !!
+	 * the hotk, so we can do anything!
 	 */
 	struct asus_hotk *hotk = (struct asus_hotk *) data;
 
@@ -749,6 +767,9 @@
 		hotk->model = L3X;
 	else if (strncmp(model->string.pointer, "M2", 2) == 0)
 		hotk->model = M2X;
+	else if (strncmp(model->string.pointer, "M3N", 3) == 0 ||
+		 strncmp(model->string.pointer, "S1N", 3) == 0)
+		hotk->model = M3N; /* S1300N is similar enough */
 	else if (strncmp(model->string.pointer, "L2", 2) == 0)
 		hotk->model = L2X;
 	else if (strncmp(model->string.pointer, "L8", 2) == 0)
@@ -761,8 +782,10 @@
 		hotk->model = D1X;
 	else if (strncmp(model->string.pointer, "A1", 2) == 0)
 		hotk->model = A1X;
+	else if (strncmp(model->string.pointer, "A2", 2) == 0)
+		hotk->model = A2X;
 	else if (strncmp(model->string.pointer, "J1", 2) == 0)
-		hotk->model = J1X;
+		hotk->model = S2X;
 
 
 	if (hotk->model == END_MODEL) {
@@ -850,17 +873,20 @@
 		       "  Notify Handler installed successfully\n");
 	}
 
-	/* For HOTK laptops: init the hotk->brightness value */
+	/* For laptops without GPLV: init the hotk->brightness value */
 	if ((!hotk->methods->brightness_get) && (!hotk->methods->brightness_status) &&
 	    (hotk->methods->brightness_up && hotk->methods->brightness_down)) {
 		status = acpi_evaluate_object(NULL, hotk->methods->brightness_down,
 					      NULL, NULL);
 		if (ACPI_FAILURE(status))
 			printk(KERN_NOTICE "  Error changing brightness\n");
-		status = acpi_evaluate_object(NULL, hotk->methods->brightness_up,
-					      NULL, NULL);
-		if (ACPI_FAILURE(status))
-			printk(KERN_NOTICE "  Error changing brightness\n");
+		else {
+			status = acpi_evaluate_object(NULL, hotk->methods->brightness_up,
+						      NULL, NULL);
+			if (ACPI_FAILURE(status))
+				printk(KERN_NOTICE "  Strange, error changing" 
+				       " brightness\n");
+		}
 	}
 
       end:
--- a/drivers/acpi/Kconfig	2003-08-23 18:42:46.000000000 +0200
+++ b/drivers/acpi/Kconfig	2003-08-23 19:13:13.000000000 +0200
@@ -170,6 +170,9 @@
           display brightness and output, switching the LCD backlight on and off,
           and most importantly, allows you to blink those fancy LEDs intended
           for reporting mail and wireless status.
+
+	  Note: display switching code is currently considered EXPERIMENTAL,
+	  toying with these values may even lock your machine.
           
           All settings are changed via /proc/acpi/asus directory entries. Owner
           and group for these entries can be set with asus_uid and asus_gid

--uQr8t48UFsdbeI+V--


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
