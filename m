From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: [PATCH] acpi4asus update
Date: Tue, 23 Mar 2004 01:01:43 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040323000143.GA13711@hell.org.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="C7zPtVaVf+AK4Oqc"
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


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline

Hi,
The attached patch updates the acpi4asus driver to version 0.28 through the
following changes:
- Added support for Samsung P30
- Fixed an oops triggered by non-standard hardware (Samsung P30)
- Added support for L4400L and M6800N

The patch also removes some superfluous data. It doesn't include the
copy_from_user() conversion, it will be released as a separate patch.

The code should apply to current bk (both for 2.4 and 2.6). The patch is
also available here:
http://hell.org.pl/~sziwan/asus/acpi4asus-0.27-0.28.diff

Please apply, TIA,
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org

--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: attachment; filename="acpi4asus-0.27-0.28.diff"

--- a/drivers/acpi/asus_acpi.c	2004-02-18 14:36:31.000000000 +0100
+++ b/drivers/acpi/asus_acpi.c	2004-03-22 22:40:10.000000000 +0100
@@ -41,7 +41,7 @@
 #include <acpi/acpi_drivers.h>
 #include <acpi/acpi_bus.h>
 
-#define ASUS_ACPI_VERSION "0.27"
+#define ASUS_ACPI_VERSION "0.28"
 
 #define PROC_ASUS       "asus"	//the directory
 #define PROC_MLED       "mled"
@@ -125,12 +125,11 @@ struct asus_hotk {
 		L5x,      //L5800C 
 		L8L,      //L8400L
 		M1A,      //M1300A
-		M2E,      //M2400E
+		M2E,      //M2400E, L4400L
+		P30,	  //Samsung P30
 		S1x,      //S1300A, but also L1400B and M2400A (L84F)
 		S2x,      //S200 (J1 reported), Victor MP-XP7210
-		          //TODO  A1370D does not seem to have an ATK device 
-		          // L8400 model doesn't have ATK
-		xxN,      //M2400N, M3700N, S1300N (Centrino)
+		xxN,      //M2400N, M3700N, M6800N, S1300N, S5200N (Centrino)
 		END_MODEL
 	} model;              //Models currently supported
 	u16 event_count[128]; //count for each event TODO make this better
@@ -140,6 +139,7 @@ struct asus_hotk {
 #define A1x_PREFIX "\\_SB.PCI0.ISA.EC0."
 #define L3C_PREFIX "\\_SB.PCI0.PX40.ECD0."
 #define M1A_PREFIX "\\_SB.PCI0.PX40.EC0."
+#define P30_PREFIX "\\_SB.PCI0.LPCB.EC0."
 #define S1x_PREFIX "\\_SB.PCI0.PX40."
 #define S2x_PREFIX A1x_PREFIX
 #define xxN_PREFIX "\\_SB.PCI0.SBRG.EC0."
@@ -166,7 +166,7 @@ static struct model_data model_conf[END_
 		.mt_lcd_switch     = A1x_PREFIX "_Q10",
 		.lcd_status        = "\\BKLI",
 		.brightness_up     = A1x_PREFIX "_Q0E",
-		.brightness_down   = A1x_PREFIX "_Q0F",
+		.brightness_down   = A1x_PREFIX "_Q0F"
 	},
 
 	{
@@ -176,11 +176,8 @@ static struct model_data model_conf[END_
 		.wled_status       = "\\SG66",
 		.mt_lcd_switch     = "\\Q10",
 		.lcd_status        = "\\BAOF",
-		.brightness_up     = "\\Q0E",
-		.brightness_down   = "\\Q0F",
 		.brightness_set    = "SPLV",
 		.brightness_get    = "GPLV",
-		.brightness_status = "\\CMOD",
 		.display_set       = "SDSP",
 		.display_get       = "\\INFB"
 	},
@@ -217,11 +214,8 @@ static struct model_data model_conf[END_
 		.mt_wled           = "WLED",
 		.mt_lcd_switch     = L3C_PREFIX "_Q10",
 		.lcd_status        = "\\GL32",
-		.brightness_up     = L3C_PREFIX "_Q0F",
-		.brightness_down   = L3C_PREFIX "_Q0E",
 		.brightness_set    = "SPLV",
 		.brightness_get    = "GPLV",
-		.brightness_status = "\\BLVL",
 		.display_set       = "SDSP",
 		.display_get       = "\\_SB.PCI0.PCI1.VGAC.NMAP"
 	},
@@ -233,11 +227,8 @@ static struct model_data model_conf[END_
 		.mt_wled           = "WLED",
 		.mt_lcd_switch     = "\\Q10",
 		.lcd_status        = "\\BKLG",
-		.brightness_up     = "\\Q0E",
-		.brightness_down   = "\\Q0F",
 		.brightness_set    = "SPLV",
 		.brightness_get    = "GPLV",
-		.brightness_status = "\\BLVL",
 		.display_set       = "SDSP",
 		.display_get       = "\\INFB"
 	},
@@ -257,14 +248,10 @@ static struct model_data model_conf[END_
 	{
 		.name              = "L5x",
 		.mt_mled           = "MLED",
-//		.mt_wled           = "WLED",
-//		.wled_status       = "\\WRED",
-/* Present, but not controlled by ACPI */
+/* WLED present, but not controlled by ACPI */
 		.mt_tled           = "TLED",
 		.mt_lcd_switch     = "\\Q0D",
 		.lcd_status        = "\\BAOF",
-		.brightness_up     = "\\Q0C",
-		.brightness_down   = "\\Q0B",
 		.brightness_set    = "SPLV",
 		.brightness_get    = "GPLV",
 		.display_set       = "SDSP",
@@ -294,8 +281,6 @@ static struct model_data model_conf[END_
 		.mt_wled           = "WLED",
 		.mt_lcd_switch     = "\\Q10",
 		.lcd_status        = "\\GP06",
-		.brightness_up     = "\\Q0E",
-		.brightness_down   = "\\Q0F",
 		.brightness_set    = "SPLV",
 		.brightness_get    = "GPLV",
 		.display_set       = "SDSP",
@@ -303,17 +288,26 @@ static struct model_data model_conf[END_
 	},
 
 	{
+		.name              = "P30",
+		.mt_wled           = "WLED",
+		.mt_lcd_switch     = P30_PREFIX "_Q0E",
+		.lcd_status        = "\\BKLT",
+		.brightness_up     = P30_PREFIX "_Q68",
+		.brightness_down   = P30_PREFIX "_Q69",
+		.brightness_get    = "GPLV",
+		.display_set       = "SDSP",
+		.display_get       = "\\DNXT"
+	},
+
+	{
 		.name              = "S1x",
 		.mt_mled           = "MLED",
 		.mled_status       = "\\EMLE",
 		.mt_wled           = "WLED",
 		.mt_lcd_switch     = S1x_PREFIX "Q10" ,
 		.lcd_status        = "\\PNOF",
-		.brightness_up     = S1x_PREFIX "Q0F",
-		.brightness_down   = S1x_PREFIX "Q0E",
 		.brightness_set    = "SPLV",
-		.brightness_get    = "GPLV",
-		.brightness_status = "\\BRIT",
+		.brightness_get    = "GPLV"
 	},
 
 	{
@@ -323,22 +317,17 @@ static struct model_data model_conf[END_
 		.mt_lcd_switch     = S2x_PREFIX "_Q10",
 		.lcd_status        = "\\BKLI",
 		.brightness_up     = S2x_PREFIX "_Q0B",
-		.brightness_down   = S2x_PREFIX "_Q0A",
+		.brightness_down   = S2x_PREFIX "_Q0A"
 	},
 
 	{
 		.name              = "xxN",
 		.mt_mled           = "MLED",
-//		.mt_wled           = "WLED",
-//		.wled_status       = "\\PO33",
-/* Present, but not controlled by ACPI */
+/* WLED present, but not controlled by ACPI */
 		.mt_lcd_switch     = xxN_PREFIX "_Q10",
 		.lcd_status        = "\\BKLT",
-		.brightness_up     = xxN_PREFIX "_Q0F",
-		.brightness_down   = xxN_PREFIX "_Q0E",
 		.brightness_set    = "SPLV",
 		.brightness_get    = "GPLV",
-		.brightness_status = "\\LBTN",
 		.display_set       = "SDSP",
 		.display_get       = "\\ADVG"
 	}
@@ -663,6 +652,23 @@ proc_write_lcd(struct file *file, const 
 }
 
 
+static int read_brightness(struct asus_hotk *hotk)
+{
+	int value;
+	
+	if(hotk->methods->brightness_get) { /* SPLV/GPLV laptop */
+		if (!read_acpi_int(hotk->handle, hotk->methods->brightness_get, 
+				   &value))
+			printk(KERN_WARNING "Asus ACPI: Error reading brightness\n");
+	} else if (hotk->methods->brightness_status) { /* For D1 for example */
+		if (!read_acpi_int(NULL, hotk->methods->brightness_status, 
+				   &value))
+			printk(KERN_WARNING "Asus ACPI: Error reading brightness\n");
+	} else /* No GPLV method */
+		value = hotk->brightness;
+	return value;
+}
+
 /*
  * Change the brightness level
  */
@@ -679,7 +685,7 @@ static void set_brightness(int value, st
 	}
 
 	/* No SPLV method if we are here, act as appropriate */
-	value -= hotk->brightness;
+	value -= read_brightness(hotk);
 	while (value != 0) {
 		status = acpi_evaluate_object(NULL, (value > 0) ? 
 					      hotk->methods->brightness_up : 
@@ -692,23 +698,6 @@ static void set_brightness(int value, st
 	return;
 }
 
-static int read_brightness(struct asus_hotk *hotk)
-{
-	int value;
-	
-	if(hotk->methods->brightness_get) { /* SPLV/GPLV laptop */
-		if (!read_acpi_int(hotk->handle, hotk->methods->brightness_get, 
-				   &value))
-			printk(KERN_WARNING "Asus ACPI: Error reading brightness\n");
-	} else if (hotk->methods->brightness_status) { /* For D1 for example */
-		if (!read_acpi_int(NULL, hotk->methods->brightness_status, 
-				   &value))
-			printk(KERN_WARNING "Asus ACPI: Error reading brightness\n");
-	} else /* No GPLV method */
-		value = hotk->brightness;
-	return value;
-}
-
 static int
 proc_read_brn(char *page, char **start, off_t off, int count, int *eof,
 	      void *data)
@@ -929,12 +918,29 @@ static int __init asus_hotk_get_info(str
 		return -ENODEV;
 	}
 
-	/* For testing purposes */
+	/* This needs to be called for some laptops to init properly */
 	if (!read_acpi_int(hotk->handle, "BSTS", &bsts_result))
 		printk(KERN_WARNING "  Error calling BSTS\n");
 	else if (bsts_result)
 		printk(KERN_NOTICE "  BSTS called, 0x%02x returned\n", bsts_result);
 
+	/* Samsung P30 has a device with a valid _HID whose INIT does not 
+	 * return anything. Catch this one and any similar here */
+	if (buffer.pointer == NULL) {
+		if (asus_info && /* Samsung P30 */
+		    strncmp(asus_info->oem_table_id, "ODEM", 4) == 0) {
+			hotk->model = P30;
+			printk(KERN_NOTICE "  Samsung P30 detected, supported\n");
+		} else {
+			hotk->model = M2E;
+			printk(KERN_WARNING "  no string returned by INIT\n");
+			printk(KERN_WARNING "  trying default values, supply "
+			       "the developers with your DSDT\n");
+		}
+		hotk->methods = &model_conf[hotk->model];
+		return AE_OK;
+	}
+	
 	model = (union acpi_object *) buffer.pointer;
 	if (model->type == ACPI_TYPE_STRING) {
 		printk(KERN_NOTICE "  %s model detected, ", model->string.pointer);
@@ -953,12 +959,14 @@ static int __init asus_hotk_get_info(str
 		hotk->model = L8L;
 	else if (strncmp(model->string.pointer, "M2N", 3) == 0 ||
 		 strncmp(model->string.pointer, "M3N", 3) == 0 ||
+		 strncmp(model->string.pointer, "M6N", 3) == 0 ||
 		 strncmp(model->string.pointer, "S1N", 3) == 0 ||
 		 strncmp(model->string.pointer, "S5N", 3) == 0)
 		hotk->model = xxN;
 	else if (strncmp(model->string.pointer, "M1", 2) == 0)
 		hotk->model = M1A;
-	else if (strncmp(model->string.pointer, "M2", 2) == 0)
+	else if (strncmp(model->string.pointer, "M2", 2) == 0 ||
+		 strncmp(model->string.pointer, "L4E", 3) == 0)
 		hotk->model = M2E;
 	else if (strncmp(model->string.pointer, "L2", 2) == 0)
 		hotk->model = L2D;
@@ -994,6 +1002,13 @@ static int __init asus_hotk_get_info(str
 	else if (strncmp(model->string.pointer, "S5N", 3) == 0)
 		hotk->methods->mt_mled = NULL; 
 	/* S5N has no MLED */
+	else if (strncmp(model->string.pointer, "M6N", 3) == 0) {
+		hotk->methods->display_get = NULL; //TODO
+		hotk->methods->lcd_status = "\\_SB.BKLT";
+		hotk->methods->mt_wled = "WLED";
+		hotk->methods->wled_status = "\\_SB.PCI0.SBRG.SG13";
+	/* M6N differs slightly and has a usable WLED */
+	}
 	else if (asus_info) {
 		if (strncmp(asus_info->oem_table_id, "L1", 2) == 0)
 			hotk->methods->mled_status = NULL;

--C7zPtVaVf+AK4Oqc--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
