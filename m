From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH V2 05/13] ACPI: check and enumerate CMOS RTC devices explicitly
Date: Fri, 14 Mar 2014 00:16:45 +0800
Message-ID: <1394727413-3587-6-git-send-email-rui.zhang@intel.com>
References: <1394727413-3587-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1394727413-3587-1-git-send-email-rui.zhang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: bhelgaas@google.com, matthew.garrett@nebula.com, rafael.j.wysocki@intel.com, dmitry.torokhov@gmail.com, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-acpi@vger.kernel.org

For CMOS RTC devices, the acpi pnp scan handler does not work because
there is already a cmos rtc scan handler installed, thus we need to
check those devices and enumerate them to PNP bus explicitly.

Note: the CMOS RTC device id is not removed from ACPI pnp scan handler
      id list, thus, if cmos rtc scan handler is compiled out, the ACPI
      pnp scan handler will be attached to the CMOS RTC devices instead,
      to prevent these devices from being created to platform bus.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/acpi_pnp.c |   22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_pnp.c b/drivers/acpi/acpi_pnp.c
index 2a7f86f..6fa482a 100644
--- a/drivers/acpi/acpi_pnp.c
+++ b/drivers/acpi/acpi_pnp.c
@@ -349,9 +349,29 @@ static struct acpi_scan_handler acpi_pnp_handler = {
 	.attach = acpi_pnp_scan_handler_attach,
 };
 
+/*
+ * For CMOS RTC devices, the acpi pnp spcan handler does not work because
+ * there is already a cmos rtc scan handler installed, thus we need to
+ * check those devices and enumerate them to PNP bus explicitly.
+ */
+static int is_cmos_rtc_device(struct acpi_device *adev)
+{
+	struct acpi_device_id ids[] = {
+		{ "PNP0B00" },
+		{ "PNP0B01" },
+		{ "PNP0B02" },
+		{""},
+	};
+	return !acpi_match_device_ids(adev, ids);
+}
+
 bool acpi_is_pnp_device(struct acpi_device *device)
 {
-	return !!(device->handler == &acpi_pnp_handler);
+	if (device->handler == &acpi_pnp_handler)
+		return true;
+	if (is_cmos_rtc_device(device))
+		return true;
+	return false;
 }
 EXPORT_SYMBOL_GPL(acpi_is_pnp_device);
 
-- 
1.7.9.5
