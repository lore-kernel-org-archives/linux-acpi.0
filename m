From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH] ACPI / LPSS: don't crash if a device has no MMIO resources
Date: Mon,  2 Sep 2013 13:30:25 +0300
Message-ID: <1378117825-15852-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Imre Kaloz <kaloz@openwrt.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Intel LPSS devices that are enumerated from ACPI have both MMIO and IRQ
resources returned in their _CRS method. However, Apple Macbook Air with
Haswell has LPSS devices enumerated from PCI bus instead and _CRS method
returns only an interrupt number (but the device has _HID set that causes
the scan handler to match it).

The current ACPI / LPSS code sets pdata->dev_desc only when MMIO resource
is found for the device and in case of Macbook Air it is never found. That
leads to a NULL pointer dereference in register_device_clock().

Correct this by always setting the pdata->dev_desc.

Reported-and-tested-by: Imre Kaloz <kaloz@openwrt.org>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: stable@vger.kernel.org # 3.10+
---
 drivers/acpi/acpi_lpss.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 6a38218..fb78bb9 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -257,12 +257,13 @@ static int acpi_lpss_create_device(struct acpi_device *adev,
 				pdata->mmio_size = resource_size(&rentry->res);
 			pdata->mmio_base = ioremap(rentry->res.start,
 						   pdata->mmio_size);
-			pdata->dev_desc = dev_desc;
 			break;
 		}
 
 	acpi_dev_free_resource_list(&resource_list);
 
+	pdata->dev_desc = dev_desc;
+
 	if (dev_desc->clk_required) {
 		ret = register_device_clock(adev, pdata);
 		if (ret) {
-- 
1.8.4.rc3
