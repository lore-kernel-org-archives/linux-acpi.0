From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: [PATCH] ACPI: make asus_acpi.c unregister and unload if no ASUS devices found
Date: Fri, 16 Sep 2005 11:38:03 -0600
Message-ID: <200509161138.03228.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>, julien.lerouge-GANU6spQydw@public.gmane.org, acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Drivers should not assume that acpi_bus_register_driver() returns the
number of devices claimed.  I want to change acpi_bus_register_driver()
so it returns only success or failure, as pci_register_driver() does.

Previous discussion of this issue:
    http://sourceforge.net/mailarchive/message.php?msg_id=12489146

I don't have an ASUS laptop to test on, but on my HP dl360, it
does report the appropriate error when attempting to load the module:

    $ sudo insmod drivers/acpi/asus_acpi.ko
    insmod: error inserting 'drivers/acpi/asus_acpi.ko': -1 No such device

Signed-off-by: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>

Index: test/drivers/acpi/asus_acpi.c
===================================================================
--- test.orig/drivers/acpi/asus_acpi.c	2005-09-15 12:29:54.000000000 -0600
+++ test/drivers/acpi/asus_acpi.c	2005-09-16 07:55:51.000000000 -0600
@@ -1108,6 +1108,8 @@
 	return result;
 }
 
+static int asus_hotk_found;
+
 static int __init asus_hotk_add(struct acpi_device *device)
 {
 	acpi_status status = AE_OK;
@@ -1169,6 +1171,8 @@
 		}
 	}
 
+	asus_hotk_found = 1;
+
       end:
 	if (result) {
 		kfree(hotk);
@@ -1215,7 +1219,19 @@
 	asus_proc_dir->owner = THIS_MODULE;
 
 	result = acpi_bus_register_driver(&asus_hotk_driver);
-	if (result < 1) {
+	if (result < 0) {
+		remove_proc_entry(PROC_ASUS, acpi_root_dir);
+		return -ENODEV;
+	}
+
+	/*
+	 * This is a bit of a kludge.  We only want this module loaded
+	 * for ASUS systems, but there's currently no way to probe the
+	 * ACPI namespace for ASUS HIDs.  So we just return failure if
+	 * we didn't find one, which will cause the module to be
+	 * unloaded.
+	 */
+	if (!asus_hotk_found) {
 		acpi_bus_unregister_driver(&asus_hotk_driver);
 		remove_proc_entry(PROC_ASUS, acpi_root_dir);
 		return -ENODEV;


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
