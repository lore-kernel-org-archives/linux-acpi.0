From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [PATCH V3 1/8] ACPI: Add stubs for (un)register_acpi_bus_type
Date: Wed,  9 May 2012 23:00:28 +0800
Message-ID: <1336575635-13120-2-git-send-email-tianyu.lan@intel.com>
References: <1336575635-13120-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:1053 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758582Ab2EIPJA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 9 May 2012 11:09:00 -0400
In-Reply-To: <1336575635-13120-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, stern@rowland.harvard.edu, sarah.a.sharp@linux.intel.com, mjg59@srcf.ucam.org, mfm@muteddisk.com, Matthew Garrett <mjg@redhat.com>, Lan Tianyu <tianyu.lan@intel.com>

From: Matthew Garrett <mjg@redhat.com>

It's unreasonable to have CONFIG_ACPI for these in drivers, so add some
stub functions.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/acpi/glue.c     |    2 ++
 include/acpi/acpi_bus.h |    5 +++++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
index 29a4a5c..1564e09 100644
--- a/drivers/acpi/glue.c
+++ b/drivers/acpi/glue.c
@@ -69,6 +69,7 @@ static struct acpi_bus_type *acpi_get_bus_type(struct bus_type *type)
 	up_read(&bus_type_sem);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(register_acpi_bus_type);
 
 static int acpi_find_bridge_device(struct device *dev, acpi_handle * handle)
 {
@@ -85,6 +86,7 @@ static int acpi_find_bridge_device(struct device *dev, acpi_handle * handle)
 	up_read(&bus_type_sem);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(unregister_acpi_bus_type);
 
 /* Get device's handler per its address under its parent */
 struct acpi_find_child {
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index f1c8ca6..c909984 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -407,6 +407,11 @@ static inline int acpi_pm_device_sleep_wake(struct device *dev, bool enable)
 }
 #endif
 
+#else	/* CONFIG_ACPI */
+
+static int register_acpi_bus_type(struct acpi_bus_type *bus) { return 0; }
+static int unregister_acpi_bus_type(struct acpi_bus_type *bus) { return 0; }
+
 #endif				/* CONFIG_ACPI */
 
 #endif /*__ACPI_BUS_H__*/
-- 
1.7.6.rc2.8.g28eb

