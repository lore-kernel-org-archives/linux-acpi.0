From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH V5 07/12] ACPI: use platform bus as the default bus for _HID enumeration
Date: Tue,  8 Apr 2014 00:06:54 +0800
Message-ID: <1396886819-2637-8-git-send-email-rui.zhang@intel.com>
References: <1396886819-2637-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1396886819-2637-1-git-send-email-rui.zhang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: bhelgaas@google.com, matthew.garrett@nebula.com, rafael.j.wysocki@intel.com, dmitry.torokhov@gmail.com, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-acpi@vger.kernel.org

Because of the growing demand for enumerating ACPI devices to platform bus,
this patch changes the code to enumerate ACPI devices with _HID to
platform bus by default, unless the device already has a scan handler attached.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/acpi_platform.c |   28 ----------------------------
 drivers/acpi/scan.c          |    5 ++++-
 2 files changed, 4 insertions(+), 29 deletions(-)

diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
index dbfe49e..33376a9 100644
--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -22,24 +22,6 @@
 
 ACPI_MODULE_NAME("platform");
 
-/*
- * The following ACPI IDs are known to be suitable for representing as
- * platform devices.
- */
-static const struct acpi_device_id acpi_platform_device_ids[] = {
-
-	{ "PNP0D40" },
-	{ "ACPI0003" },
-	{ "VPC2004" },
-	{ "BCM4752" },
-
-	/* Intel Smart Sound Technology */
-	{ "INT33C8" },
-	{ "80860F28" },
-
-	{ }
-};
-
 /**
  * acpi_create_platform_device - Create platform device for ACPI device node
  * @adev: ACPI device node to create a platform device for.
@@ -125,13 +107,3 @@ int acpi_create_platform_device(struct acpi_device *adev,
 	kfree(resources);
 	return 1;
 }
-
-static struct acpi_scan_handler platform_handler = {
-	.ids = acpi_platform_device_ids,
-	.attach = acpi_create_platform_device,
-};
-
-void __init acpi_platform_init(void)
-{
-	acpi_scan_add_handler(&platform_handler);
-}
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 451e7d9..44c4668 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2094,6 +2094,10 @@ static int acpi_scan_attach_handler(struct acpi_device *device)
 				break;
 		}
 	}
+
+	if (device->pnp.type.platform_id && !device->handler)
+		acpi_create_platform_device(device, NULL);
+
 	return ret;
 }
 
@@ -2253,7 +2257,6 @@ int __init acpi_scan_init(void)
 	acpi_pci_root_init();
 	acpi_pci_link_init();
 	acpi_processor_init();
-	acpi_platform_init();
 	acpi_lpss_init();
 	acpi_cmos_rtc_init();
 	acpi_container_init();
-- 
1.7.9.5
