From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: [PATCH 2/4] acpi4asus update:
Date: Thu, 9 Sep 2004 00:45:11 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040908224511.GB9953@hell.org.pl>
References: <20040908223807.GA9953@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040908223807.GA9953-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
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
This patch accounts for the new behaviour of acpi_bus_register_driver() and
makes the driver bail out if no suitable devices to bind to are found.

I *think* that with the acpi_disabled check in place calling
acpi_bus_unregister_driver() is safe in that context.

Please apply, TIA

Signed-off-by: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>

Index: asus_core.c
===================================================================
RCS file: /cvsroot/acpi4asus/acpi4asus/driver/asus_core.c,v
retrieving revision 1.104
retrieving revision 1.105
diff -u -r1.104 -r1.105
--- a/drivers/acpi/asus_acpi.c	5 Aug 2004 18:43:54 -0000	1.104
+++ b/drivers/acpi/asus_acpi.c	7 Sep 2004 22:23:41 -0000	1.105
@@ -1214,20 +1214,24 @@
 {
 	int result;
 
+	if (acpi_disabled)
+		return -ENODEV;
+
 	asus_proc_dir = proc_mkdir(PROC_ASUS, acpi_root_dir);
 	if (!asus_proc_dir) {
 		printk(KERN_ERR "Asus ACPI: Unable to create /proc entry\n");
-		return(-ENODEV);
+		return -ENODEV;
 	}
 	asus_proc_dir->owner = THIS_MODULE;
 
 	result = acpi_bus_register_driver(&asus_hotk_driver);
-	if (result < 0) {
+	if (result < 1) {
+		acpi_bus_unregister_driver(&asus_hotk_driver);
 		remove_proc_entry(PROC_ASUS, acpi_root_dir);
-		return(-ENODEV);
+		return -ENODEV;
 	}
 
-	return(0);
+	return 0;
 }
 
 
-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
