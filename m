From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v5 1/6] ACPI: Constify argument to acpi_device_is_present()
Date: Wed, 31 May 2017 14:52:07 +0300
Message-ID: <1496231532-23601-2-git-send-email-sakari.ailus@linux.intel.com>
References: <1496231532-23601-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:57247 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751125AbdEaLxc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 31 May 2017 07:53:32 -0400
In-Reply-To: <1496231532-23601-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: devicetree@vger.kernel.org, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com, frowand.list@gmail.com, kieran.bingham@ideasonboard.com

This will be needed in constifying the fwnode API.

The side effects the function had have been moved to the callers.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/device_pm.c | 4 +++-
 drivers/acpi/internal.h  | 2 +-
 drivers/acpi/scan.c      | 9 +++------
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index 798d500..b404604 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -262,8 +262,10 @@ int acpi_bus_init_power(struct acpi_device *device)
 		return -EINVAL;
 
 	device->power.state = ACPI_STATE_UNKNOWN;
-	if (!acpi_device_is_present(device))
+	if (!acpi_device_is_present(device)) {
+		device->flags.initialized = false;
 		return -ENXIO;
+	}
 
 	result = acpi_device_get_power(device, &state);
 	if (result)
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 66229ff..7300240 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -111,7 +111,7 @@ int acpi_device_setup_files(struct acpi_device *dev);
 void acpi_device_remove_files(struct acpi_device *dev);
 void acpi_device_add_finalize(struct acpi_device *device);
 void acpi_free_pnp_ids(struct acpi_device_pnp *pnp);
-bool acpi_device_is_present(struct acpi_device *adev);
+bool acpi_device_is_present(const struct acpi_device *adev);
 bool acpi_device_is_battery(struct acpi_device *adev);
 bool acpi_device_is_first_physical_node(struct acpi_device *adev,
 					const struct device *dev);
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index e39ec7b..b609cbf 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1567,13 +1567,9 @@ static int acpi_bus_type_and_status(acpi_handle handle, int *type,
 	return 0;
 }
 
-bool acpi_device_is_present(struct acpi_device *adev)
+bool acpi_device_is_present(const struct acpi_device *adev)
 {
-	if (adev->status.present || adev->status.functional)
-		return true;
-
-	adev->flags.initialized = false;
-	return false;
+	return adev->status.present || adev->status.functional;
 }
 
 static bool acpi_scan_handler_matching(struct acpi_scan_handler *handler,
@@ -1831,6 +1827,7 @@ static void acpi_bus_attach(struct acpi_device *device)
 	acpi_bus_get_status(device);
 	/* Skip devices that are not present. */
 	if (!acpi_device_is_present(device)) {
+		device->flags.initialized = false;
 		acpi_device_clear_enumerated(device);
 		device->flags.power_manageable = 0;
 		return;
-- 
2.7.4

