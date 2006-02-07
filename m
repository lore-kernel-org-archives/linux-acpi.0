From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 1/4] ACPI: update asus_acpi driver registration
Date: Mon, 6 Feb 2006 17:17:36 -0700
Message-ID: <200602061717.36445.bjorn.helgaas@hp.com>
References: <200602061716.41470.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel8.hp.com ([156.153.255.206]:12737 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S932425AbWBGARh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Feb 2006 19:17:37 -0500
In-Reply-To: <200602061716.41470.bjorn.helgaas@hp.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Karol Kozimor <sziwan@hell.org.pl>, julien.lerouge@free.fr, acpi4asus-user@lists.sourceforge.net, Stelian Pop <stelian@popies.net>, Narayanan R S <nars@kadamba.org>, Andrew Morton <akpm@osdl.org>

Remove the assumption that acpi_bus_register_driver() returns the
number of devices claimed.  Returning the count is unreliable because
devices may be hot-plugged in the future (admittedly not applicable
for this driver).

Since the hardware for this driver is not hot-pluggable, determine
whether the hardware is present by noticing calls to the .add()
method.  It would be better to probe the ACPI namespace for the
ASUS HIDs, and load the driver only when we find one, but ACPI
doesn't support that yet.

I don't have an ASUS laptop to test on, but on my HP dl360, it
does report the appropriate error when attempting to load the module:

    $ sudo insmod drivers/acpi/asus_acpi.ko
    insmod: error inserting 'drivers/acpi/asus_acpi.ko': -1 No such device

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work-mm4/drivers/acpi/asus_acpi.c
===================================================================
--- work-mm4.orig/drivers/acpi/asus_acpi.c	2006-02-01 16:24:45.000000000 -0700
+++ work-mm4/drivers/acpi/asus_acpi.c	2006-02-02 15:12:46.000000000 -0700
@@ -1119,6 +1119,8 @@
 	return result;
 }
 
+static int asus_hotk_found;
+
 static int __init asus_hotk_add(struct acpi_device *device)
 {
 	acpi_status status = AE_OK;
@@ -1180,6 +1182,8 @@
 		}
 	}
 
+	asus_hotk_found = 1;
+
       end:
 	if (result) {
 		kfree(hotk);
@@ -1226,7 +1230,19 @@
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
