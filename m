From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: [PATCH 3/4] acpi4asus update: support M6R
Date: Thu, 9 Sep 2004 00:48:31 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040908224831.GC9953@hell.org.pl>
References: <20040908223807.GA9953@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040908224511.GB9953-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
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
This patch adds support for the M6700R laptops.
Please apply, TIA

Signed-off-by: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>

Index: asus_core.c
===================================================================
RCS file: /cvsroot/acpi4asus/acpi4asus/driver/asus_core.c,v
retrieving revision 1.105
retrieving revision 1.106
diff -u -r1.105 -r1.106
--- a/drivers/acpi/asus_acpi.c	7 Sep 2004 22:23:41 -0000	1.105
+++ b/drivers/acpi/asus_acpi.c	7 Sep 2004 23:00:29 -0000	1.106
@@ -133,6 +133,7 @@
 		M1A,      //M1300A
 		M2E,      //M2400E, L4400L
 		M6N,      //M6800N
+		M6R,      //M6700R
 		P30,	  //Samsung P30
 		S1x,      //S1300A, but also L1400B and M2400A (L84F)
 		S2x,      //S200 (J1 reported), Victor MP-XP7210
@@ -320,6 +321,18 @@
 		.display_set       = "SDSP",
 		.display_get       = "\\SSTE"
 	},
+	{
+		.name              = "M6R",
+		.mt_mled           = "MLED",
+		.mt_wled           = "WLED",
+		.mt_lcd_switch     = xxN_PREFIX "_Q10",
+		.lcd_status        = "\\_SB.PCI0.SBSM.SEO4",
+		.brightness_set    = "SPLV",
+		.brightness_get    = "GPLV",
+		.display_set       = "SDSP",
+		.display_get       = "\\SSTE"
+	},
+
 
 	{
 		.name              = "P30",
@@ -1035,6 +1048,8 @@
 		hotk->model = L4R;
 	else if (strncmp(model->string.pointer, "M6N", 3) == 0)
 		hotk->model = M6N;
+	else if (strncmp(model->string.pointer, "M6R", 3) == 0)
+		hotk->model = M6R;
 	else if (strncmp(model->string.pointer, "M2N", 3) == 0 ||
 		 strncmp(model->string.pointer, "M3N", 3) == 0 ||
 		 strncmp(model->string.pointer, "M5N", 3) == 0 ||
 
-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
