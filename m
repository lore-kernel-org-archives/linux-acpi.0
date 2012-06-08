From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [PATCH] ACPI: Fix misplacing the export symbol of (un)register_acpi_bus_type
Date: Fri,  8 Jun 2012 15:47:54 +0800
Message-ID: <1339141674-10686-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:19172 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760519Ab2FHHyr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Jun 2012 03:54:47 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: Lan Tianyu <tianyu.lan@intel.com>, mjg@redhat.com, linux-acpi@vger.kernel.org

Misplace the symbol of (un)register_acpi_bus_type in the commit 66886d6f8
due to my change error to Matthew's patch. This patch is to correct it.

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/acpi/glue.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
index 1564e09..243ee85 100644
--- a/drivers/acpi/glue.c
+++ b/drivers/acpi/glue.c
@@ -39,6 +39,7 @@ int register_acpi_bus_type(struct acpi_bus_type *type)
 	}
 	return -ENODEV;
 }
+EXPORT_SYMBOL_GPL(register_acpi_bus_type);
 
 int unregister_acpi_bus_type(struct acpi_bus_type *type)
 {
@@ -54,6 +55,7 @@ int unregister_acpi_bus_type(struct acpi_bus_type *type)
 	}
 	return -ENODEV;
 }
+EXPORT_SYMBOL_GPL(unregister_acpi_bus_type);
 
 static struct acpi_bus_type *acpi_get_bus_type(struct bus_type *type)
 {
@@ -69,7 +71,6 @@ static struct acpi_bus_type *acpi_get_bus_type(struct bus_type *type)
 	up_read(&bus_type_sem);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(register_acpi_bus_type);
 
 static int acpi_find_bridge_device(struct device *dev, acpi_handle * handle)
 {
@@ -86,7 +87,6 @@ static int acpi_find_bridge_device(struct device *dev, acpi_handle * handle)
 	up_read(&bus_type_sem);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(unregister_acpi_bus_type);
 
 /* Get device's handler per its address under its parent */
 struct acpi_find_child {
-- 
1.7.6.rc2.8.g28eb

