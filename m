From: Len Brown <lenb@kernel.org>
Subject: [PATCH 19/49] ACPI: introduce module_acpi_driver() helper macro
Date: Sat,  6 Oct 2012 16:09:40 -0400
Message-ID: <0d2cf8f5aab358c897902ebad40fa4edd1b4556e.1349554106.git.len.brown@intel.com>
References: <1349554210-29978-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:42316 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751284Ab2JFUPm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 6 Oct 2012 16:15:42 -0400
In-Reply-To: <1349554210-29978-1-git-send-email-lenb@kernel.org>
In-Reply-To: <a950c135e5b2be6ef7518d54d98a7901db1b377a.1349554105.git.len.brown@intel.com>
References: <a950c135e5b2be6ef7518d54d98a7901db1b377a.1349554105.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Len Brown <len.brown@intel.com>

From: Mika Westerberg <mika.westerberg@linux.intel.com>

Add a helper macro module_acpi_driver() which reduces the boilerplate code
for ACPI drivers. This is similar what is done for other busses (PCI, SPI,
I2C etc).

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/acpi/acpi_bus.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index bde976e..bddd909 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -381,6 +381,19 @@ int acpi_match_device_ids(struct acpi_device *device,
 int acpi_create_dir(struct acpi_device *);
 void acpi_remove_dir(struct acpi_device *);
 
+
+/**
+ * module_acpi_driver(acpi_driver) - Helper macro for registering an ACPI driver
+ * @__acpi_driver: acpi_driver struct
+ *
+ * Helper macro for ACPI drivers which do not do anything special in module
+ * init/exit. This eliminates a lot of boilerplate. Each module may only
+ * use this macro once, and calling it replaces module_init() and module_exit()
+ */
+#define module_acpi_driver(__acpi_driver) \
+	module_driver(__acpi_driver, acpi_bus_register_driver, \
+		      acpi_bus_unregister_driver)
+
 /*
  * Bind physical devices with ACPI devices
  */
-- 
1.8.0.rc0.18.gf84667d

