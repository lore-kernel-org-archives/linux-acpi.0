From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: [patch 1/2] acpi: check if parent is on dock
Date: Thu, 7 Sep 2006 16:13:13 -0700
Message-ID: <20060907161313.a0c0d135.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:50598 "EHLO mga02.intel.com")
	by vger.kernel.org with ESMTP id S1422696AbWIGXNL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Sep 2006 19:13:11 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, len.brown@intel.com

When determining if a device is on a dock station, we should
check the parent of the device as well.

Signed-off-by:  Kristen Carlson Accardi <kristen.c.accardi@intel.com>

Index: 2.6-git/drivers/acpi/dock.c
===================================================================
--- 2.6-git.orig/drivers/acpi/dock.c
+++ 2.6-git/drivers/acpi/dock.c
@@ -586,20 +586,28 @@ static acpi_status
 find_dock_devices(acpi_handle handle, u32 lvl, void *context, void **rv)
 {
 	acpi_status status;
-	acpi_handle tmp;
+	acpi_handle tmp, parent;
 	struct dock_station *ds = (struct dock_station *)context;
 	struct dock_dependent_device *dd;
 
 	status = acpi_bus_get_ejd(handle, &tmp);
-	if (ACPI_FAILURE(status))
-		return AE_OK;
+	if (ACPI_FAILURE(status)) {
+		/* try the parent device as well */
+		status = acpi_get_parent(handle, &parent);
+		if (ACPI_FAILURE(status))
+			goto fdd_out;
+		/* see if parent is dependent on dock */
+		status = acpi_bus_get_ejd(parent, &tmp);
+		if (ACPI_FAILURE(status))
+			goto fdd_out;
+	}
 
 	if (tmp == ds->handle) {
 		dd = alloc_dock_dependent_device(handle);
 		if (dd)
 			add_dock_dependent_device(ds, dd);
 	}
-
+fdd_out:
 	return AE_OK;
 }
 
