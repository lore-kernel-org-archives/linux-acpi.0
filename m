From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 4/4] ACPI: simplify scan.c coding
Date: Mon, 6 Feb 2006 17:19:46 -0700
Message-ID: <200602061719.46634.bjorn.helgaas@hp.com>
References: <200602061716.41470.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel8.hp.com ([156.153.255.206]:49093 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S932389AbWBGATq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Feb 2006 19:19:46 -0500
In-Reply-To: <200602061716.41470.bjorn.helgaas@hp.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Karol Kozimor <sziwan@hell.org.pl>, julien.lerouge@free.fr, acpi4asus-user@lists.sourceforge.net, Stelian Pop <stelian@popies.net>, Narayanan R S <nars@kadamba.org>, Andrew Morton <akpm@osdl.org>

No functional changes; just remove leftover, unused "buffer" and
simplify control flow (no need to remember error values and goto
the end, when we can simply return the value directly).

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work-mm4/drivers/acpi/scan.c
===================================================================
--- work-mm4.orig/drivers/acpi/scan.c	2006-02-02 15:13:02.000000000 -0700
+++ work-mm4/drivers/acpi/scan.c	2006-02-02 15:13:20.000000000 -0700
@@ -236,12 +236,9 @@
 
 int acpi_match_ids(struct acpi_device *device, char *ids)
 {
-	int error = 0;
-	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
-
 	if (device->flags.hardware_id)
 		if (strstr(ids, device->pnp.hardware_id))
-			goto Done;
+			return 0;
 
 	if (device->flags.compatible_ids) {
 		struct acpi_compatible_id_list *cid_list = device->pnp.cid_list;
@@ -250,15 +247,10 @@
 		/* compare multiple _CID entries against driver ids */
 		for (i = 0; i < cid_list->count; i++) {
 			if (strstr(ids, cid_list->id[i].value))
-				goto Done;
+				return 0;
 		}
 	}
-	error = -ENOENT;
-
-      Done:
-	if (buffer.pointer)
-		acpi_os_free(buffer.pointer);
-	return error;
+	return -ENOENT;
 }
 
 static acpi_status
@@ -641,21 +633,19 @@
  */
 int acpi_bus_unregister_driver(struct acpi_driver *driver)
 {
-	int error = 0;
-
 	ACPI_FUNCTION_TRACE("acpi_bus_unregister_driver");
 
-	if (driver) {
-		acpi_driver_detach(driver);
+	if (!driver)
+		return_VALUE(-EINVAL);
 
-		if (!atomic_read(&driver->references)) {
-			spin_lock(&acpi_device_lock);
-			list_del_init(&driver->node);
-			spin_unlock(&acpi_device_lock);
-		}
-	} else
-		error = -EINVAL;
-	return_VALUE(error);
+	acpi_driver_detach(driver);
+
+	if (!atomic_read(&driver->references)) {
+		spin_lock(&acpi_device_lock);
+		list_del_init(&driver->node);
+		spin_unlock(&acpi_device_lock);
+	}
+	return_VALUE(0);
 }
 
 EXPORT_SYMBOL(acpi_bus_unregister_driver);
