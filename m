From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: [RFC PATCH] ACPI / scan: Introduce _CCA parsing logic and setting up device coherency
Date: Wed, 1 Apr 2015 10:20:20 -0500
Message-ID: <1427901620-2194-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bl2on0122.outbound.protection.outlook.com ([65.55.169.122]:7510
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752092AbbDAPUd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 1 Apr 2015 11:20:33 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, mika.westerberg@linux.intel.com, robert.moore@intel.com, lv.zheng@intel.com, lenb@kernel.org, hanjun.guo@linaro.org
Cc: catalin.marinas@arm.com, will.deacon@arm.com, al.stone@linaro.org, msalter@redhat.com, gregkh@linuxfoundation.org, leo.duran@amd.com, arnd@arndb.de, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

ACPI v5.1 introduced _CCA object for specifying cache coherency attribute
for devices. This patch implements a logic, which traverses device namespace
to parse the coherency information, and calling the corresponded
arch_setup_dma_ops().

It checks the _CCA during ACPI scan, and setup coherency during acpi_device creation.
Then, this is propagted to the platform_device when it is created at later time.

CC: Mark Salter <msalter@redhat.com>
CC: Hanjun Guo <hanjun.guo@linaro.org>
CC: Al Stone <al.stone@linaro.org>
Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
---

NOTE:

The original patch has been submitted by Mark Salter, and discussed here:

* http://comments.gmane.org/gmane.linux.acpi.devel/70424

One of the reveiw comment was dissusing whether we need the do/while loop for
travesing parents of the device.  AFAIK, there are no APIs that would do upsearch
from a particular node.  The acpi_get_handle() is the closest one, but it is using
ACPI_NS_NO_UPSEARCH.

This has been rebased and tested with:
	* http://git.linaro.org/leg/acpi/acpi.git acpi-5.1-v11
	* [V8 PATCH 0/3] Introduce ACPI support for ahci_platform driver
	  (https://lkml.org/lkml/2015/3/30/729)

 drivers/acpi/acpi_platform.c |  5 +++-
 drivers/acpi/scan.c          | 56 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
index 1284138..47e37a8 100644
--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -108,9 +108,12 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev)
 	if (IS_ERR(pdev))
 		dev_err(&adev->dev, "platform device creation failed: %ld\n",
 			PTR_ERR(pdev));
-	else
+	else {
+		arch_setup_dma_ops(&pdev->dev, 0, 0, NULL,
+				   is_device_dma_coherent(&adev->dev));
 		dev_dbg(&adev->dev, "created platform device %s\n",
 			dev_name(&pdev->dev));
+	}
 
 	kfree(resources);
 	return pdev;
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 230ec983..4d81c55 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -11,6 +11,7 @@
 #include <linux/kthread.h>
 #include <linux/dmi.h>
 #include <linux/nls.h>
+#include <linux/dma-mapping.h>
 
 #include <asm/pgtable.h>
 
@@ -57,6 +58,9 @@ struct acpi_device_bus_id{
 	struct list_head node;
 };
 
+static int acpi_bus_type_and_status(acpi_handle handle, int *type,
+				    unsigned long long *sta);
+
 void acpi_scan_lock_acquire(void)
 {
 	mutex_lock(&acpi_scan_lock);
@@ -1327,6 +1331,51 @@ void acpi_bus_put_acpi_device(struct acpi_device *adev)
 	put_device(&adev->dev);
 }
 
+/**
+ * acpi_check_and_set_coherency - check and set cache coherency of a device
+ * @device: ACPI device
+ *
+ * Search a device and its parents for a _CCA method and calculate
+ * the effective coherency property of the device. If found, set up
+ * appropriate dma_ops for the device.
+ *
+ * Note From ACPIv5.1 spec:
+ * If used _CCA must be included under all bus-master-capable
+ * devices defined as children of \_SB. The value of _CCA is inherited
+ * by all descendants of these devices, so it need not be repeated for
+ * their children devices and will be ignored by OSPM if it is provided
+ * there.
+ */
+static int acpi_check_and_set_coherency(struct acpi_device *device)
+{
+	acpi_status status;
+	unsigned long long eff_cca = ~0ULL;
+	acpi_handle tmp, handle = device->handle;
+
+	/* Calculate effective _CCA from all parents of this device */
+	do {
+		unsigned long cca;
+
+		status = acpi_get_handle(handle, "_CCA", &tmp);
+		if (ACPI_SUCCESS(status)) {
+			status = acpi_evaluate_integer(tmp, "_CCA", NULL, &cca);
+			/* Other values besides 0 and 1 are reserved */
+			if (ACPI_FAILURE(status) || (cca != 0 && cca != 1))
+				return -EINVAL;
+			eff_cca = cca;
+		}
+
+		status = acpi_get_parent(handle, &handle);
+		if (ACPI_FAILURE(status))
+			break;
+	} while (ACPI_SUCCESS(status));
+
+	if (eff_cca != ~0ULL)
+		arch_setup_dma_ops(&device->dev, 0, 0, NULL, eff_cca);
+
+	return 0;
+}
+
 int acpi_device_add(struct acpi_device *device,
 		    void (*release)(struct device *))
 {
@@ -1398,6 +1447,13 @@ int acpi_device_add(struct acpi_device *device,
 		device->dev.parent = &device->parent->dev;
 	device->dev.bus = &acpi_bus_type;
 	device->dev.release = release;
+
+	result = acpi_check_and_set_coherency(device);
+	if (result) {
+		dev_err(&device->dev, "Error getting device _CCA information\n");
+		goto err;
+	}
+
 	result = device_add(&device->dev);
 	if (result) {
 		dev_err(&device->dev, "Error registering device\n");
-- 
2.1.0

