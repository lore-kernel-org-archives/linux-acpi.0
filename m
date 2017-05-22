From: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v4 1/5] ACPI: Constify argument to acpi_device_is_present()
Date: Mon, 22 May 2017 11:53:18 +0300
Message-ID: <1495443202-22817-2-git-send-email-sakari.ailus@linux.intel.com>
References: <1495443202-22817-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1495443202-22817-1-git-send-email-sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ahs3-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This will be needed in constifying the fwnode API.

The side effects the function had have been moved to the callers.

Signed-off-by: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
