From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: [PATCH 3/2] acpi4asus update: bug / typo
Date: Sat, 10 Jul 2004 00:54:25 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040709225425.GC31054@hell.org.pl>
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
There was a nasty typo in the code that got duplicated by the "remove /proc
files" patch. Fix that, and also trailing spaces. Please apply to both
trees.

Signed-off-by: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>


--- a/drivers/acpi/asus_acpi.c	2004-06-29 23:39:06.000000000 +0200
+++ b/drivers/acpi/asus_acpi.c	2004-07-10 00:40:54.000000000 +0200
@@ -897,13 +901,12 @@
 	}
 	
 	if ((hotk->methods->brightness_up && hotk->methods->brightness_down) ||
-	    (hotk->methods->brightness_get && hotk->methods->brightness_get)) {
+	    (hotk->methods->brightness_get && hotk->methods->brightness_set)) {
 		asus_proc_add(PROC_BRN, &proc_write_brn, &proc_read_brn, mode, device);
 	}
 
 	if (hotk->methods->display_set) {
 		asus_proc_add(PROC_DISP, &proc_write_disp, &proc_read_disp, mode, device);
-
 	}
 
 	return 0;
@@ -914,7 +917,7 @@
 	struct asus_hotk* hotk = acpi_driver_data(device);
 
 
-	if(acpi_device_dir(device)){
+	if(acpi_device_dir(device)) {
 		remove_proc_entry(PROC_INFO,acpi_device_dir(device));
 		if (hotk->methods->mt_wled)
 			remove_proc_entry(PROC_WLED,acpi_device_dir(device));
@@ -922,11 +925,12 @@
 			remove_proc_entry(PROC_MLED,acpi_device_dir(device));
 		if (hotk->methods->mt_tled)
 			remove_proc_entry(PROC_TLED,acpi_device_dir(device));
-		if (hotk->methods->mt_lcd_switch && hotk->methods->lcd_status) 
+		if (hotk->methods->mt_lcd_switch && hotk->methods->lcd_status)
 			remove_proc_entry(PROC_LCD, acpi_device_dir(device));
-		if ((hotk->methods->brightness_up && hotk->methods->brightness_down) || (hotk->methods->brightness_get && hotk->methods->brightness_get)) 
+		if ((hotk->methods->brightness_up && hotk->methods->brightness_down) ||
+		    (hotk->methods->brightness_get && hotk->methods->brightness_set))
 			remove_proc_entry(PROC_BRN, acpi_device_dir(device));
-		if (hotk->methods->display_set) 
+		if (hotk->methods->display_set)
 			remove_proc_entry(PROC_DISP, acpi_device_dir(device));
 	}
 	return 0;


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
