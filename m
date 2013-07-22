From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 1/3] ACPICA: Add acpi_update_interfaces public interface
Date: Mon, 22 Jul 2013 16:08:16 +0800
Message-ID: <7f53bb4cfcc97f5c9c560882751cc78cde121d27.1374474116.git.lv.zheng@intel.com>
References: <cover.1369380671.git.lv.zheng@intel.com> <cover.1374474116.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:12396 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751880Ab3GVIIX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 22 Jul 2013 04:08:23 -0400
In-Reply-To: <cover.1374474116.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

Add new API to allow OSPM to disable/enable specific types of _OSI
interface strings.

ACPICA does not have the knowledge about whether an _OSI interface string
is an OS vendor string or a feature group string and there isn't any API
interface to allow OSPM to install a new interface string as a feature
group string.
This patch simply adds all feature group strings defined by ACPI
specification into the acpi_default_supported_interfaces with
ACPI_OSI_FEATURE flag set to fix this gap.  This patch also adds codes to
keep their default states as ACPI_OSI_INVALID before the initialization and
after the termination.

Reported by Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Reviewed-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Acked-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/aclocal.h |    3 ++
 drivers/acpi/acpica/acutils.h |    2 ++
 drivers/acpi/acpica/utosi.c   |   77 ++++++++++++++++++++++++++++++++++-------
 drivers/acpi/acpica/utxface.c |   29 ++++++++++++++++
 include/acpi/acpixf.h         |    2 ++
 include/acpi/actypes.h        |   14 ++++++++
 6 files changed, 114 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index dfed265..42f1be3 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -955,6 +955,9 @@ struct acpi_interface_info {
 
 #define ACPI_OSI_INVALID                0x01
 #define ACPI_OSI_DYNAMIC                0x02
+#define ACPI_OSI_FEATURE                0x04
+#define ACPI_OSI_DEFAULT_INVALID        0x08
+#define ACPI_OSI_OPTIONAL_FEATURE       (ACPI_OSI_FEATURE | ACPI_OSI_DEFAULT_INVALID | ACPI_OSI_INVALID)
 
 struct acpi_port_info {
 	char *name;
diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index 3c76ede..f7b3f68 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -470,6 +470,8 @@ acpi_status acpi_ut_install_interface(acpi_string interface_name);
 
 acpi_status acpi_ut_remove_interface(acpi_string interface_name);
 
+acpi_status acpi_ut_update_interfaces(u8 action);
+
 struct acpi_interface_info *acpi_ut_get_interface(acpi_string interface_name);
 
 acpi_status acpi_ut_osi_implementation(struct acpi_walk_state *walk_state);
diff --git a/drivers/acpi/acpica/utosi.c b/drivers/acpi/acpica/utosi.c
index 7e80772..8856bd3 100644
--- a/drivers/acpi/acpica/utosi.c
+++ b/drivers/acpi/acpica/utosi.c
@@ -77,21 +77,20 @@ static struct acpi_interface_info acpi_default_supported_interfaces[] = {
 
 	/* Feature Group Strings */
 
-	{"Extended Address Space Descriptor", NULL, 0, 0}
+	{"Extended Address Space Descriptor", NULL, ACPI_OSI_FEATURE, 0},
 
 	/*
 	 * All "optional" feature group strings (features that are implemented
-	 * by the host) should be dynamically added by the host via
-	 * acpi_install_interface and should not be manually added here.
-	 *
-	 * Examples of optional feature group strings:
-	 *
-	 * "Module Device"
-	 * "Processor Device"
-	 * "3.0 Thermal Model"
-	 * "3.0 _SCP Extensions"
-	 * "Processor Aggregator Device"
+	 * by the host) should be dynamically modified to VALID by the host via
+	 * acpi_install_interface or acpi_update_interfaces. Such optional feature
+	 * group strings are set as INVALID by default here.
 	 */
+
+	{"Module Device", NULL, ACPI_OSI_OPTIONAL_FEATURE, 0},
+	{"Processor Device", NULL, ACPI_OSI_OPTIONAL_FEATURE, 0},
+	{"3.0 Thermal Model", NULL, ACPI_OSI_OPTIONAL_FEATURE, 0},
+	{"3.0 _SCP Extensions", NULL, ACPI_OSI_OPTIONAL_FEATURE, 0},
+	{"Processor Aggregator Device", NULL, ACPI_OSI_OPTIONAL_FEATURE, 0}
 };
 
 /*******************************************************************************
@@ -158,11 +157,20 @@ acpi_status acpi_ut_interface_terminate(void)
 	while (next_interface) {
 		acpi_gbl_supported_interfaces = next_interface->next;
 
-		/* Only interfaces added at runtime can be freed */
-
 		if (next_interface->flags & ACPI_OSI_DYNAMIC) {
+
+			/* Only interfaces added at runtime can be freed */
+
 			ACPI_FREE(next_interface->name);
 			ACPI_FREE(next_interface);
+		} else {
+			/* Interface is in static list. Reset it to invalid or valid. */
+
+			if (next_interface->flags & ACPI_OSI_DEFAULT_INVALID) {
+				next_interface->flags |= ACPI_OSI_INVALID;
+			} else {
+				next_interface->flags &= ~ACPI_OSI_INVALID;
+			}
 		}
 
 		next_interface = acpi_gbl_supported_interfaces;
@@ -278,6 +286,49 @@ acpi_status acpi_ut_remove_interface(acpi_string interface_name)
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_ut_update_interfaces
+ *
+ * PARAMETERS:  action              - Actions to be performed during the
+ *                                    update
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Update _OSI interface strings, disabling or enabling OS vendor
+ *              strings or/and feature group strings.
+ *              Caller MUST hold acpi_gbl_osi_mutex
+ *
+ ******************************************************************************/
+
+acpi_status acpi_ut_update_interfaces(u8 action)
+{
+	struct acpi_interface_info *next_interface;
+
+	next_interface = acpi_gbl_supported_interfaces;
+	while (next_interface) {
+		if (((next_interface->flags & ACPI_OSI_FEATURE) &&
+		     (action & ACPI_FEATURE_STRINGS)) ||
+		    (!(next_interface->flags & ACPI_OSI_FEATURE) &&
+		     (action & ACPI_VENDOR_STRINGS))) {
+			if (action & ACPI_DISABLE_INTERFACES) {
+
+				/* Mark the interfaces as invalid */
+
+				next_interface->flags |= ACPI_OSI_INVALID;
+			} else {
+				/* Mark the interfaces as valid */
+
+				next_interface->flags &= ~ACPI_OSI_INVALID;
+			}
+		}
+
+		next_interface = next_interface->next;
+	}
+
+	return (AE_OK);
+}
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_ut_get_interface
  *
  * PARAMETERS:  interface_name      - The interface to find
diff --git a/drivers/acpi/acpica/utxface.c b/drivers/acpi/acpica/utxface.c
index 6505774..03a211e 100644
--- a/drivers/acpi/acpica/utxface.c
+++ b/drivers/acpi/acpica/utxface.c
@@ -389,6 +389,34 @@ ACPI_EXPORT_SYMBOL(acpi_install_interface_handler)
 
 /*****************************************************************************
  *
+ * FUNCTION:    acpi_update_interfaces
+ *
+ * PARAMETERS:  action              - Actions to be performed during the
+ *                                    update
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Update _OSI interface strings, disabling or enabling OS vendor
+ *              string or/and feature group strings.
+ *
+ ****************************************************************************/
+acpi_status acpi_update_interfaces(u8 action)
+{
+	acpi_status status;
+
+	status = acpi_os_acquire_mutex(acpi_gbl_osi_mutex, ACPI_WAIT_FOREVER);
+	if (ACPI_FAILURE(status)) {
+		return (status);
+	}
+
+	status = acpi_ut_update_interfaces(action);
+
+	acpi_os_release_mutex(acpi_gbl_osi_mutex);
+	return (status);
+}
+
+/*****************************************************************************
+ *
  * FUNCTION:    acpi_check_address_range
  *
  * PARAMETERS:  space_id            - Address space ID
@@ -402,6 +430,7 @@ ACPI_EXPORT_SYMBOL(acpi_install_interface_handler)
  *              ASL operation region address ranges.
  *
  ****************************************************************************/
+
 u32
 acpi_check_address_range(acpi_adr_space_type space_id,
 			 acpi_physical_address address,
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 1b09300..c2705e8 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -146,6 +146,8 @@ acpi_status acpi_install_interface(acpi_string interface_name);
 
 acpi_status acpi_remove_interface(acpi_string interface_name);
 
+acpi_status acpi_update_interfaces(u8 action);
+
 u32
 acpi_check_address_range(acpi_adr_space_type space_id,
 			 acpi_physical_address address,
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index a64adcc..549bdfb 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -1144,4 +1144,18 @@ struct acpi_memory_list {
 #endif
 };
 
+/* _OSI update actions */
+
+#define ACPI_VENDOR_STRINGS                 0x01
+#define ACPI_FEATURE_STRINGS                0x02
+#define ACPI_ENABLE_INTERFACES              0x00
+#define ACPI_DISABLE_INTERFACES             0x04
+
+#define ACPI_DISABLE_ALL_VENDOR_STRINGS     (ACPI_DISABLE_INTERFACES | ACPI_VENDOR_STRINGS)
+#define ACPI_DISABLE_ALL_FEATURE_STRINGS    (ACPI_DISABLE_INTERFACES | ACPI_FEATURE_STRINGS)
+#define ACPI_DISABLE_ALL_STRINGS            (ACPI_DISABLE_INTERFACES | ACPI_VENDOR_STRINGS | ACPI_FEATURE_STRINGS)
+#define ACPI_ENABLE_ALL_VENDOR_STRINGS      (ACPI_ENABLE_INTERFACES | ACPI_VENDOR_STRINGS)
+#define ACPI_ENABLE_ALL_FEATURE_STRINGS     (ACPI_ENABLE_INTERFACES | ACPI_FEATURE_STRINGS)
+#define ACPI_ENABLE_ALL_STRINGS             (ACPI_ENABLE_INTERFACES | ACPI_VENDOR_STRINGS | ACPI_FEATURE_STRINGS)
+
 #endif				/* __ACTYPES_H__ */
-- 
1.7.10

