From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: Re: [RESEND] Asus ACPI 0.26 released
Date: Tue, 30 Sep 2003 22:53:33 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030930205333.GA30824@hell.org.pl>
References: <20030930202435.GA4242@hell.org.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="fdj2RfSjLxBAspz7"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030930202435.GA4242-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline

Thus wrote Karol Kozimor:
[sigh]

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org

--fdj2RfSjLxBAspz7
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
--- a/MAINTAINERS	2003-08-02 23:35:08.000000000 +0200
+++ b/MAINTAINERS	2003-08-23 20:44:06.000000000 +0200
@@ -257,6 +257,16 @@
 L:	linux-net-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
 S:	Maintained
 
+ASUS ACPI EXTRAS DRIVER
+P:	Karol Kozimor
+M:	sziwan-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
+P:	Julien Lerouge
+M:	julien.lerouge-GANU6spQydw@public.gmane.org
+L:	acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
+W:	http://sourceforge.net/projects/acpi4asus
+W:	http://julien.lerouge.free.fr
+S:	Maintained
+
 ATM
 P:	Chas Williams
 M:	chas-vT06rRrALxcmhCb6mdbn6A@public.gmane.org

--fdj2RfSjLxBAspz7
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
--- a/MAINTAINERS	2003-08-23 20:48:24.000000000 +0200
+++ b/MAINTAINERS	2003-08-23 20:47:58.000000000 +0200
@@ -284,6 +284,16 @@
 L:	linux-net-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
 S:	Maintained
 
+ASUS ACPI EXTRAS DRIVER
+P:	Karol Kozimor
+M:	sziwan-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
+P:	Julien Lerouge
+M:	julien.lerouge-GANU6spQydw@public.gmane.org
+L:	acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
+W:	http://sourceforge.net/projects/acpi4asus
+W:	http://julien.lerouge.free.fr
+S:	Maintained
+
 ATM
 P:	Chas Williams
 M:	chas-vT06rRrALxcmhCb6mdbn6A@public.gmane.org

--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: attachment; filename="acpi4asus-0.25-0.26.diff"

--- a/drivers/acpi/asus_acpi.c	2003-09-05 15:35:30.000000000 +0200
+++ b/drivers/acpi/asus_acpi.c	2003-09-05 15:01:20.000000000 +0200
@@ -30,10 +30,6 @@
  *  add Fn key status
  *  Add mode selection on module loading (parameter) -> still necessary?
  *  Complete display switching -- may require dirty hacks?
- *  Complete support for Centrino laptops
- *  Reading certain fields (e.g. \SG66 in A2500H) consistently fails, while 
- *    reading others (\BAOF, the same machine) succeeds. Why?
- *
  */
 
 #include <linux/config.h>
@@ -49,7 +45,7 @@
 #include <acpi/acpi_drivers.h>
 #include <acpi/acpi_bus.h>
 
-#define ASUS_ACPI_VERSION "0.25"
+#define ASUS_ACPI_VERSION "0.26"
 
 #define PROC_ASUS       "asus"	//the directory
 #define PROC_MLED       "mled"
@@ -122,16 +119,18 @@
 		A2X,		//A2500H
 		D1X,		//D1
 		L1X,		//L1400B
-		L2X,		//L200D -> TODO check Q11 (Fn+F8)
+		L2X,		//L2000D -> TODO check Q11 (Fn+F8)
 				//	   Calling this method simply hangs the
 				//	   computer, ISMI method hangs the laptop.
 		L3D,		//L3400D
 		L3X,		//L3C
+		L5X,		//L5C TODO this model seems to have one more
+		                //         LED, add support
 		M2X,		//M2400E
 		M3N,		//M3700N, but also S1300N -> TODO WLED
 		S1X,		//S1300A -> TODO special keys do not work ?
 		S2X,		//S200 (J1 reported), Victor MP-XP7210
-				//TODO  A1370D does not seems to have a ATK device 
+				//TODO  A1370D does not seem to have an ATK device 
 				//	L8400 model doesn't have ATK
 		END_MODEL
 	} model;		//Models currently supported
@@ -180,6 +179,9 @@
 	 L3X_PREFIX "_Q0F", L3X_PREFIX "_Q0E", "SPLV", "GPLV", "\\BLVL", "SDSP", 
 	 "\\_SB.PCI0.PCI1.VGAC.NMAP"},
 
+	{"L5X", "MLED", NULL, "WLED", "WRED", "\\Q0D", "\\BAOF", 
+	 "\\Q0C","\\Q0B", "SPLV", "GPLV", NULL, "SDSP", "\\INFB"},
+	 
 	{"M2X", "MLED", NULL, "WLED", NULL, "\\Q10", "\\GP06", 
 	 "\\Q0E","\\Q0F", "SPLV", "GPLV", NULL, "SDSP", "\\INFB"},
 
@@ -267,6 +269,7 @@
 		void *data)
 {
 	int len = 0;
+	int sfun;
 	struct asus_hotk *hotk = (struct asus_hotk *) data;
 	char buf[16];		//enough for all info
 	/*
@@ -275,28 +278,27 @@
 	 */
 
 	len += sprintf(page, ACPI_HOTK_NAME " " ASUS_ACPI_VERSION "\n");
-	len +=
-	    sprintf(page + len, "Model reference    : %s\n",
-		    hotk->methods->name);
+	len += sprintf(page + len, "Model reference    : %s\n", 
+		       hotk->methods->name);
+	if(read_acpi_int(hotk->handle, "SFUN", &sfun))
+		len += sprintf(page + len, "SFUN value         : 0x%04x\n", sfun);
 	if (asus_info) {
-		snprintf(buf, 5, "%s", asus_info->signature);
-		len += sprintf(page + len, "ACPI signature     : %s\n", buf);
 		snprintf(buf, 16, "%d", asus_info->length);
-		len += sprintf(page + len, "Table length       : %s\n", buf);
-		snprintf(buf, 16, "%d", asus_info->revision);
-		len += sprintf(page + len, "ACPI minor version : %s\n", buf);
+		len += sprintf(page + len, "DSDT length        : %s\n", buf);
 		snprintf(buf, 16, "%d", asus_info->checksum);
-		len += sprintf(page + len, "Checksum           : %s\n", buf);
+		len += sprintf(page + len, "DSDT checksum      : %s\n", buf);
+		snprintf(buf, 16, "%d", asus_info->revision);
+		len += sprintf(page + len, "DSDT revision      : %s\n", buf);
 		snprintf(buf, 7, "%s", asus_info->oem_id);
-		len += sprintf(page + len, "OEM identification : %s\n", buf);
+		len += sprintf(page + len, "OEM id             : %s\n", buf);
 		snprintf(buf, 9, "%s", asus_info->oem_table_id);
 		len += sprintf(page + len, "OEM table id       : %s\n", buf);
 		snprintf(buf, 16, "%x", asus_info->oem_revision);
-		len += sprintf(page + len, "OEM rev number     : 0x%s\n", buf);
+		len += sprintf(page + len, "OEM revision       : 0x%s\n", buf);
 		snprintf(buf, 5, "%s", asus_info->asl_compiler_id);
-		len += sprintf(page + len, "ASL comp vendor ID : %s\n", buf);
+		len += sprintf(page + len, "ASL comp vendor id : %s\n", buf);
 		snprintf(buf, 16, "%x", asus_info->asl_compiler_revision);
-		len += sprintf(page + len, "ASL comp rev number: 0x%s\n", buf);
+		len += sprintf(page + len, "ASL comp revision  : 0x%s\n", buf);
 	}
 
 	return len;
@@ -322,7 +324,7 @@
 				  &led_status))
 			len =  sprintf(page, "%d\n", led_status);
 		else
-			printk(KERN_NOTICE "Asus ACPI: Error reading MLED "
+			printk(KERN_WARNING "Asus ACPI: Error reading MLED "
 			       "status\n");
 	} else {
 		len = sprintf(page, "%d\n", (hotk->status & MLED_ON) ? 1 : 0);
@@ -352,7 +354,7 @@
 	/* We don't have to check mt_mled exists if we are here :) */
 	if (!write_acpi_int(hotk->handle, hotk->methods->mt_mled, led_out,
 			    NULL))
-		printk(KERN_NOTICE "Asus ACPI: MLED write failed\n");
+		printk(KERN_WARNING "Asus ACPI: MLED write failed\n");
 
 
 
@@ -373,11 +375,11 @@
 	int led_status;
 
 	if (hotk->methods->wled_status) {
-		if (read_acpi_int(NULL, hotk->methods->mled_status, 
+		if (read_acpi_int(NULL, hotk->methods->wled_status, 
 				  &led_status))
 			len = sprintf(page, "%d\n", led_status);
 		else
-			printk(KERN_NOTICE "Asus ACPI: Error reading WLED "
+			printk(KERN_WARNING "Asus ACPI: Error reading WLED "
 			       "status\n");
 	} else {
 		len = sprintf(page, "%d\n", (hotk->status & WLED_ON) ? 1 : 0);
@@ -404,7 +406,7 @@
 	/* We don't have to check if mt_wled exists if we are here :) */
 	if (!write_acpi_int(hotk->handle, hotk->methods->mt_wled, led_out,
 			    NULL))
-		printk(KERN_NOTICE "Asus ACPI: WLED write failed\n");
+		printk(KERN_WARNING "Asus ACPI: WLED write failed\n");
 
 
 	return count;
@@ -417,7 +419,7 @@
 
 	/* We don't have to check anything, if we are here */
 	if (!read_acpi_int(NULL, hotk->methods->lcd_status, &lcd))
-		printk(KERN_NOTICE "Asus ACPI: Error reading LCD status\n");
+		printk(KERN_WARNING "Asus ACPI: Error reading LCD status\n");
 	
 	if (hotk->model == L2X)
 		lcd = ~lcd;
@@ -456,7 +458,7 @@
 		    acpi_evaluate_object(NULL, hotk->methods->mt_lcd_switch,
 					 NULL, NULL);
 		if (ACPI_FAILURE(status))
-			printk(KERN_NOTICE "Asus ACPI: Error switching LCD\n");
+			printk(KERN_WARNING "Asus ACPI: Error switching LCD\n");
 	}
 
 	return count;
@@ -474,7 +476,7 @@
 	if(hotk->methods->brightness_set) {
 		if (!write_acpi_int(hotk->handle, hotk->methods->brightness_set, 
 				    value, NULL))
-			printk(KERN_NOTICE "Asus ACPI: Error changing brightness\n");
+			printk(KERN_WARNING "Asus ACPI: Error changing brightness\n");
 		return;
 	}
 
@@ -487,7 +489,7 @@
 					      NULL, NULL);
 		(value > 0) ? value-- : value++;
 		if (ACPI_FAILURE(status))
-			printk(KERN_NOTICE "Asus ACPI: Error changing brightness\n");
+			printk(KERN_WARNING "Asus ACPI: Error changing brightness\n");
 	}
 	return;
 }
@@ -499,11 +501,11 @@
 	if(hotk->methods->brightness_get) { /* SPLV/GPLV laptop */
 		if (!read_acpi_int(hotk->handle, hotk->methods->brightness_get, 
 				   &value))
-			printk(KERN_NOTICE "Asus ACPI: Error reading brightness\n");
+			printk(KERN_WARNING "Asus ACPI: Error reading brightness\n");
 	} else if (hotk->methods->brightness_status) { /* For D1 for example */
 		if (!read_acpi_int(NULL, hotk->methods->brightness_status, 
 				   &value))
-			printk(KERN_NOTICE "Asus ACPI: Error reading brightness\n");
+			printk(KERN_WARNING "Asus ACPI: Error reading brightness\n");
 	} else /* No GPLV method */
 		value = hotk->brightness;
 	return value;
@@ -530,7 +532,7 @@
 			/* 0 <= value <= 15 */
 		set_brightness(value, hotk);
 	} else {
-		printk(KERN_NOTICE "Asus ACPI: Error reading user input\n");
+		printk(KERN_WARNING "Asus ACPI: Error reading user input\n");
 	}
 
 	return count;
@@ -541,7 +543,7 @@
 	/* no sanity check needed for now */
 	if (!write_acpi_int(hotk->handle, hotk->methods->display_set, 
 			    value, NULL))
-		printk(KERN_NOTICE "Asus ACPI: Error setting display\n");
+		printk(KERN_WARNING "Asus ACPI: Error setting display\n");
 	return;
 }
 
@@ -558,7 +560,7 @@
 	struct asus_hotk *hotk = (struct asus_hotk *) data;
 	
 	if (!read_acpi_int(hotk->handle, hotk->methods->display_get, &value))
-		printk(KERN_NOTICE "Asus ACPI: Error reading display status\n");
+		printk(KERN_WARNING "Asus ACPI: Error reading display status\n");
 	return sprintf(page, "%d\n", value);
 }
 
@@ -580,13 +582,13 @@
 	if (sscanf(buffer, "%d", &value) == 1)
 		set_display(value, hotk);
 	else {
-		printk(KERN_NOTICE "Asus ACPI: Error reading user input\n");
+		printk(KERN_WARNING "Asus ACPI: Error reading user input\n");
 	}
 
 	return count;
 }
 
-static int asus_hotk_add_fs(struct acpi_device *device)
+static int __init asus_hotk_add_fs(struct acpi_device *device)
 {
 	struct proc_dir_entry *proc;
 	struct asus_hotk *hotk = acpi_driver_data(device);
@@ -600,7 +602,7 @@
 
 	if ((asus_uid == 0) && (asus_gid == 0)){
 		mode = S_IFREG | S_IRUGO | S_IWUGO;
-	}else{
+	} else {
 		mode = S_IFREG | S_IRUSR | S_IRGRP | S_IWUSR | S_IWGRP;
 	}
 
@@ -616,7 +618,7 @@
 		proc->uid = asus_uid;
 		proc->gid = asus_gid;;
 	} else {
-		printk(KERN_NOTICE "  Unable to create " PROC_INFOS
+		printk(KERN_WARNING "  Unable to create " PROC_INFOS
 		       " fs entry\n");
 	}
 
@@ -630,7 +632,7 @@
 			proc->uid = asus_uid;
 			proc->gid = asus_gid;;
 		} else {
-			printk(KERN_NOTICE "  Unable to create " PROC_WLED
+			printk(KERN_WARNING "  Unable to create " PROC_WLED
 			       " fs entry\n");
 		}
 	}
@@ -645,7 +647,7 @@
 			proc->uid = asus_uid;
 			proc->gid = asus_gid;;
 		} else {
-			printk(KERN_NOTICE "  Unable to create " PROC_MLED
+			printk(KERN_WARNING "  Unable to create " PROC_MLED
 			       " fs entry\n");
 		}
 	}
@@ -664,7 +666,7 @@
 			proc->uid = asus_uid;
 			proc->gid = asus_gid;;
 		} else {
-			printk(KERN_NOTICE "  Unable to create " PROC_LCD
+			printk(KERN_WARNING "  Unable to create " PROC_LCD
 			       " fs entry\n");
 		}
 	}
@@ -680,7 +682,7 @@
 			proc->uid = asus_uid;
 			proc->gid = asus_gid;;
 		} else {
-			printk(KERN_NOTICE "  Unable to create " PROC_BRN
+			printk(KERN_WARNING "  Unable to create " PROC_BRN
 			       " fs entry\n");
 		}
 	}
@@ -695,12 +697,12 @@
 			proc->uid = asus_uid;
 			proc->gid = asus_gid;;
 		} else {
-			printk(KERN_NOTICE "  Unable to create " PROC_DISP
+			printk(KERN_WARNING "  Unable to create " PROC_DISP
 			       " fs entry\n");
 		}
 	}
 
-	return (AE_OK);
+	return 0;
 }
 
 
@@ -730,19 +732,40 @@
  * This function is used to initialize the hotk with right values. In this
  * method, we can make all the detection we want, and modify the hotk struct
  */
-static int asus_hotk_get_info(struct asus_hotk *hotk)
+static int __init asus_hotk_get_info(struct asus_hotk *hotk)
 {
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	struct acpi_buffer dsdt = { ACPI_ALLOCATE_BUFFER, NULL };
 	union acpi_object *model = NULL;
+	int bsts_result;
+	acpi_status status;
 
-	/* 
-	 * We have to write 0 on init this far for all ASUS models
+	/*
+	 * Get DSDT headers early enough to allow for differentiating between 
+	 * models, but late enough to allow acpi_bus_register_driver() to fail 
+	 * before doing anything ACPI-specific. Should we encounter a machine,
+	 * which needs special handling (i.e. its hotkey device has a different
+	 * HID), this bit will be moved. A global variable asus_info contains
+	 * the DSDT header.
 	 */
+	status = acpi_get_table(ACPI_TABLE_DSDT, 1, &dsdt);
+	if (ACPI_FAILURE(status))
+		printk(KERN_WARNING "  Couldn't get the DSDT table header\n");
+	else
+		asus_info = (struct acpi_table_header *) dsdt.pointer;
+
+	/* We have to write 0 on init this far for all ASUS models */
 	if (!write_acpi_int(hotk->handle, "INIT", 0, &buffer)) {
-		printk(KERN_NOTICE "  Hotkey initialization failed\n");
+		printk(KERN_ERR "  Hotkey initialization failed\n");
 		return -ENODEV;
 	}
 
+	/* For testing purposes */
+	if (!read_acpi_int(hotk->handle, "BSTS", &bsts_result))
+		printk(KERN_WARNING "  Error calling BSTS\n");
+	else if (bsts_result)
+		printk(KERN_NOTICE "  BSTS called, 0x%02x returned\n", bsts_result);
+
 	/*
 	 * Here, we also use asus_info to make decision. For example, on INIT
 	 * method, S1X and L1X models both reports to be L84F, but they don't
@@ -772,12 +795,14 @@
 		hotk->model = M3N; /* S1300N is similar enough */
 	else if (strncmp(model->string.pointer, "L2", 2) == 0)
 		hotk->model = L2X;
-	else if (strncmp(model->string.pointer, "L8", 2) == 0)
+	else if (strncmp(model->string.pointer, "L8", 2) == 0) {
 		/* S1300A reports L84F, but L1400B too */
-		if (strncmp(asus_info->oem_table_id, "L1", 2) == 0)
-			hotk->model = L1X;
-		else
+		if (asus_info) {
+			if (strncmp(asus_info->oem_table_id, "L1", 2) == 0)
+				hotk->model = L1X;
+		} else
 			hotk->model = S1X;
+	}
 	else if (strncmp(model->string.pointer, "D1", 2) == 0)
 		hotk->model = D1X;
 	else if (strncmp(model->string.pointer, "A1", 2) == 0)
@@ -786,12 +811,13 @@
 		hotk->model = A2X;
 	else if (strncmp(model->string.pointer, "J1", 2) == 0)
 		hotk->model = S2X;
-
+	else if (strncmp(model->string.pointer, "L5", 2) == 0)
+		hotk->model = L5X;
 
 	if (hotk->model == END_MODEL) {
 		/* By default use the same values, as I don't know others */
-		printk("unsupported, trying default values, contact the "
-		       "developers\n");
+		printk("unsupported, trying default values, supply the "
+		       "developers with your DSDT\n");
 		hotk->model = L2X;
 	} else {
 		printk("supported\n");
@@ -806,7 +832,7 @@
 
 
 
-static int asus_hotk_check(struct asus_hotk *hotk)
+static int __init asus_hotk_check(struct asus_hotk *hotk)
 {
 	int result = 0;
 
@@ -820,7 +846,7 @@
 	if (hotk->device->status.present) {
 		result = asus_hotk_get_info(hotk);
 	} else {
-		printk(KERN_NOTICE "  Hotkey device not present, aborting\n");
+		printk(KERN_ERR "  Hotkey device not present, aborting\n");
 		return(-EINVAL);
 	}
 
@@ -829,7 +855,7 @@
 
 
 
-static int asus_hotk_add(struct acpi_device *device)
+static int __init asus_hotk_add(struct acpi_device *device)
 {
 	struct asus_hotk *hotk = NULL;
 	acpi_status status = AE_OK;
@@ -838,6 +864,9 @@
 	if (!device)
 		return(-EINVAL);
 
+	printk(KERN_NOTICE "Asus Laptop ACPI Extras version %s\n",
+	       ASUS_ACPI_VERSION);
+
 	hotk =
 	    (struct asus_hotk *) kmalloc(sizeof(struct asus_hotk), GFP_KERNEL);
 	if (!hotk)
@@ -865,13 +894,8 @@
 	 */
 	status = acpi_install_notify_handler(hotk->handle, ACPI_SYSTEM_NOTIFY,
 					     asus_hotk_notify, hotk);
-	if (ACPI_FAILURE(status)) {
-		printk(KERN_NOTICE
-		       "  Error installing notify handler\n");
-	} else {
-		printk(KERN_DEBUG
-		       "  Notify Handler installed successfully\n");
-	}
+	if (ACPI_FAILURE(status))
+		printk(KERN_ERR "  Error installing notify handler\n");
 
 	/* For laptops without GPLV: init the hotk->brightness value */
 	if ((!hotk->methods->brightness_get) && (!hotk->methods->brightness_status) &&
@@ -879,12 +903,12 @@
 		status = acpi_evaluate_object(NULL, hotk->methods->brightness_down,
 					      NULL, NULL);
 		if (ACPI_FAILURE(status))
-			printk(KERN_NOTICE "  Error changing brightness\n");
+			printk(KERN_WARNING "  Error changing brightness\n");
 		else {
 			status = acpi_evaluate_object(NULL, hotk->methods->brightness_up,
 						      NULL, NULL);
 			if (ACPI_FAILURE(status))
-				printk(KERN_NOTICE "  Strange, error changing" 
+				printk(KERN_WARNING "  Strange, error changing" 
 				       " brightness\n");
 		}
 	}
@@ -900,7 +924,7 @@
 
 
 
-static int asus_hotk_remove(struct acpi_device *device, int type)
+static int __exit asus_hotk_remove(struct acpi_device *device, int type)
 {
 	acpi_status status = 0;
 	struct asus_hotk *hotk = NULL;
@@ -913,7 +937,7 @@
 	status = acpi_remove_notify_handler(hotk->handle, ACPI_SYSTEM_NOTIFY,
 					    asus_hotk_notify);
 	if (ACPI_FAILURE(status))
-		printk(KERN_NOTICE "Error removing notify handler\n");
+		printk(KERN_ERR "Asus ACPI: Error removing notify handler\n");
 
 	kfree(hotk);
 
@@ -925,35 +949,17 @@
 
 static int __init asus_acpi_init(void)
 {
-	int result = 0;
-	acpi_status status = 0;
-	struct acpi_buffer dsdt = { ACPI_ALLOCATE_BUFFER, NULL };
-
-	printk(KERN_NOTICE "Asus Laptop ACPI Extras version %s\n",
-	       ASUS_ACPI_VERSION);
-	/*
-	 * Here is the code to know the model we are running on. We need to
-	 * know this before calling the acpi_bus_register_driver function, in
-	 * case the HID for the laptop we are running on is different from
-	 * ACPI_HOTK_HID, which I have never seen yet :)
-	 * 
-	 * This information is then available in the global var asus_info
-	 */
-	status = acpi_get_table(ACPI_TABLE_DSDT, 1, &dsdt);
-	if (ACPI_FAILURE(status)) {
-		printk(KERN_NOTICE "  Couldn't get the DSDT table header\n");
-	} else {
-		asus_info = (struct acpi_table_header *) dsdt.pointer;
-	}
+	int result;
 
 	asus_proc_dir = proc_mkdir(PROC_ASUS, acpi_root_dir);
-	if (!asus_proc_dir)
+	if (!asus_proc_dir) {
+		printk(KERN_ERR "Asus ACPI: Unable to create /proc entry");
 		return(-ENODEV);
+	}
 	asus_proc_dir->owner = THIS_MODULE;
 
 	result = acpi_bus_register_driver(&asus_hotk_driver);
 	if (result < 0) {
-		printk(KERN_NOTICE "  Error registering " ACPI_HOTK_NAME " \n");
 		remove_proc_entry(PROC_ASUS, acpi_root_dir);
 		return(-ENODEV);
 	}

--fdj2RfSjLxBAspz7--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
