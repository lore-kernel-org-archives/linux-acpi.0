From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: [PATCH 1/2] acpi4asus update: new models
Date: Sat, 10 Jul 2004 00:27:40 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040709222740.GA31054@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
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
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,
The following patch adds support for L4R and M5N, moves some bits for M6N
and restores WLED functionality for M2N, please apply to both trees.

Signed-off-by: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>


--- a/drivers/acpi/asus_acpi.c	2004-06-29 23:39:06.000000000 +0200
+++ b/drivers/acpi/asus_acpi.c	2004-07-09 23:28:13.000000000 +0200
@@ -123,14 +127,16 @@
 		L3C,      //L3800C
 		L3D,      //L3400D
 		L3H,      //L3H, but also L2000E
+		L4R,      //L4500R
 		L5x,      //L5800C 
 		L8L,      //L8400L
 		M1A,      //M1300A
 		M2E,      //M2400E, L4400L
+		M6N,      //M6800N
 		P30,	  //Samsung P30
 		S1x,      //S1300A, but also L1400B and M2400A (L84F)
 		S2x,      //S200 (J1 reported), Victor MP-XP7210
-		xxN,      //M2400N, M3700N, M6800N, S1300N, S5200N (Centrino)
+		xxN,      //M2400N, M3700N, M5200N, S1300N, S5200N (Centrino)
 		END_MODEL
 	} model;              //Models currently supported
 	u16 event_count[128]; //count for each event TODO make this better
@@ -247,6 +253,19 @@
 	},
 
 	{
+		.name              = "L4R",
+		.mt_mled           = "MLED",
+		.mt_wled           = "WLED",
+		.wled_status       = "\\_SB.PCI0.SBRG.SG13",
+		.mt_lcd_switch     = xxN_PREFIX "_Q10",
+		.lcd_status        = "\\_SB.PCI0.SBSM.SEO4",
+		.brightness_set    = "SPLV",
+		.brightness_get    = "GPLV", 
+		.display_set       = "SDSP",
+		.display_get       = "\\_SB.PCI0.P0P1.VGA.GETD"
+	},
+
+	{
 		.name              = "L5x",
 		.mt_mled           = "MLED",
 /* WLED present, but not controlled by ACPI */
@@ -289,6 +308,19 @@
 	},
 
 	{
+		.name              = "M6N",
+		.mt_mled           = "MLED",
+		.mt_wled           = "WLED",
+		.wled_status       = "\\_SB.PCI0.SBRG.SG13",
+		.mt_lcd_switch     = xxN_PREFIX "_Q10",
+		.lcd_status        = "\\_SB.BKLT",
+		.brightness_set    = "SPLV",
+		.brightness_get    = "GPLV",
+		.display_set       = "SDSP",
+		.display_get       = "\\SSTE"
+	},
+
+	{
 		.name              = "P30",
 		.mt_wled           = "WLED",
 		.mt_lcd_switch     = P30_PREFIX "_Q0E",
@@ -764,6 +795,7 @@
 	
 	if (!read_acpi_int(hotk->handle, hotk->methods->display_get, &value))
 		printk(KERN_WARNING "Asus ACPI: Error reading display status\n");
+	value &= 0x07; /* needed for some models, shouldn't hurt others */
 	return sprintf(page, "%d\n", value);
 }
 
@@ -998,8 +1007,13 @@
 		hotk->model = L3C;
 	else if (strncmp(model->string.pointer, "L8L", 3) == 0)
 		hotk->model = L8L;
+	else if (strncmp(model->string.pointer, "L4R", 3) == 0)
+		hotk->model = L4R;
+	else if (strncmp(model->string.pointer, "M6N", 3) == 0)
+		hotk->model = M6N;
 	else if (strncmp(model->string.pointer, "M2N", 3) == 0 ||
 		 strncmp(model->string.pointer, "M3N", 3) == 0 ||
+		 strncmp(model->string.pointer, "M5N", 3) == 0 ||
 		 strncmp(model->string.pointer, "M6N", 3) == 0 ||
 		 strncmp(model->string.pointer, "S1N", 3) == 0 ||
 		 strncmp(model->string.pointer, "S5N", 3) == 0)
@@ -1043,13 +1056,9 @@
 	else if (strncmp(model->string.pointer, "S5N", 3) == 0)
 		hotk->methods->mt_mled = NULL; 
 	/* S5N has no MLED */
-	else if (strncmp(model->string.pointer, "M6N", 3) == 0) {
-		hotk->methods->display_get = NULL; //TODO
-		hotk->methods->lcd_status = "\\_SB.BKLT";
-		hotk->methods->mt_wled = "WLED";
-		hotk->methods->wled_status = "\\_SB.PCI0.SBRG.SG13";
-	/* M6N differs slightly and has a usable WLED */
-	}
+	else if (strncmp(model->string.pointer, "M2N", 3) == 0)
+		hotk->methods->mt_wled = "WLED"; 
+	/* M2N has a usable WLED */
 	else if (asus_info) {
 		if (strncmp(asus_info->oem_table_id, "L1", 2) == 0)
 			hotk->methods->mled_status = NULL;


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
