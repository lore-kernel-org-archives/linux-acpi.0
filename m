From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: [PATCH 1/4] acpi4asus update: support W1N, v0.29
Date: Thu, 9 Sep 2004 00:38:07 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040908223807.GA9953@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,
This patch adds support for W1N notebooks and updates the version number.
Please apply, TIA

Signed-off-by: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>

--- a/drivers/acpi/asus_acpi.c	2004-08-29 16:06:06.000000000 +0200
+++ b/drivers/acpi/asus_acpi.c	2004-08-29 16:17:53.000000000 +0200
@@ -42,7 +42,7 @@
 #include <acpi/acpi_bus.h>
 #include <asm/uaccess.h>
 
-#define ASUS_ACPI_VERSION "0.28"
+#define ASUS_ACPI_VERSION "0.29"
 
 #define PROC_ASUS       "asus"	//the directory
 #define PROC_MLED       "mled"
@@ -132,7 +132,8 @@
 		P30,	  //Samsung P30
 		S1x,      //S1300A, but also L1400B and M2400A (L84F)
 		S2x,      //S200 (J1 reported), Victor MP-XP7210
-		xxN,      //M2400N, M3700N, M5200N, S1300N, S5200N (Centrino)
+		xxN,      //M2400N, M3700N, M5200N, S1300N, S5200N, W1OOON
+			  //(Centrino)
 		END_MODEL
 	} model;              //Models currently supported
 	u16 event_count[128]; //count for each event TODO make this better
@@ -1035,7 +1036,8 @@
 		 strncmp(model->string.pointer, "M5N", 3) == 0 ||
 		 strncmp(model->string.pointer, "M6N", 3) == 0 ||
 		 strncmp(model->string.pointer, "S1N", 3) == 0 ||
-		 strncmp(model->string.pointer, "S5N", 3) == 0)
+		 strncmp(model->string.pointer, "S5N", 3) == 0 ||
+                 strncmp(model->string.pointer, "W1N", 3) == 0)
 		hotk->model = xxN;
 	else if (strncmp(model->string.pointer, "M1", 2) == 0)
 		hotk->model = M1A;
@@ -1072,12 +1074,14 @@
 		hotk->methods->lcd_status = NULL; 
 	/* L2B is similar enough to L3C to use its settings, with this only 
 	   exception */
-	else if (strncmp(model->string.pointer, "S5N", 3) == 0)
+	else if (strncmp(model->string.pointer, "S5N", 3) == 0 ||
+		 strncmp(model->string.pointer, "M5N", 3) == 0)
 		hotk->methods->mt_mled = NULL; 
-	/* S5N has no MLED */
-	else if (strncmp(model->string.pointer, "M2N", 3) == 0)
+	/* S5N and M5N have no MLED */
+	else if (strncmp(model->string.pointer, "M2N", 3) == 0 ||
+		 strncmp(model->string.pointer, "W1N", 3) == 0)
 		hotk->methods->mt_wled = "WLED"; 
-	/* M2N has a usable WLED */
+	/* M2N and W1N have a usable WLED */
 	else if (asus_info) {
 		if (strncmp(asus_info->oem_table_id, "L1", 2) == 0)
 			hotk->methods->mled_status = NULL;

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
