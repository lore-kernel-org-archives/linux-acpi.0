From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: [PATCH 2/2] acpi4asus update: whitespace
Date: Sat, 10 Jul 2004 00:29:35 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040709222935.GB31054@hell.org.pl>
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
The following patch contains some comment and whitespace cleanups, please 
apply to both trees.

Signed-off-by: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>


--- a/drivers/acpi/asus_acpi.c	2004-06-29 23:39:06.000000000 +0200
+++ b/drivers/acpi/asus_acpi.c	2004-07-09 23:28:13.000000000 +0200
@@ -456,7 +456,7 @@
 		len += sprintf(page + len, "SFUN value         : 0x%04x\n", temp);
 	/*
 	 * Another value for userspace: the ASYM method returns 0x02 for
-	 * battery low and 0x04 for battery critical, it's readings tend to be
+	 * battery low and 0x04 for battery critical, its readings tend to be
 	 * more accurate than those provided by _BST. 
 	 * Note: since not all the laptops provide this method, errors are
 	 * silently ignored.
@@ -608,7 +608,6 @@
 }
 
 
-
 static int get_lcd_state(struct asus_hotk *hotk)
 {
 	int lcd = 0;
@@ -1059,7 +1058,6 @@
 		hotk->model = L5x;
 
 	if (hotk->model == END_MODEL) {
-		/* By default use the same values, as I don't know others */
 		printk("unsupported, trying default values, supply the "
 		       "developers with your DSDT\n");
 		hotk->model = M2E;
@@ -1092,7 +1090,6 @@
 }
 
 
-
 static int __init asus_hotk_check(struct asus_hotk *hotk)
 {
 	int result = 0;
@@ -1115,7 +1112,6 @@
 }
 
 
-
 static int __init asus_hotk_add(struct acpi_device *device)
 {
 	struct asus_hotk *hotk = NULL;
@@ -1182,6 +1178,7 @@
 	return(result);
 }
 
+
 static int asus_hotk_remove(struct acpi_device *device, int type)
 {
 	acpi_status status = 0;


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
