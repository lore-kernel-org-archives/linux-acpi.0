From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH] ACPI: Add acpi_device_uid() for convenience
Date: Tue, 17 Mar 2015 11:48:30 +0200
Message-ID: <1426585710-31947-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Add a nicer way to get the ACPI _UID.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 include/acpi/acpi_bus.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 61e32ec..f8009d9 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -252,6 +252,7 @@ struct acpi_device_pnp {
 #define acpi_device_bid(d)	((d)->pnp.bus_id)
 #define acpi_device_adr(d)	((d)->pnp.bus_address)
 const char *acpi_device_hid(struct acpi_device *device);
+#define acpi_device_uid(d)	((d)->pnp.unique_id)
 #define acpi_device_name(d)	((d)->pnp.device_name)
 #define acpi_device_class(d)	((d)->pnp.device_class)
 
-- 
1.9.1
