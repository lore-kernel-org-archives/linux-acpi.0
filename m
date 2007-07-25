From: Len Brown <len.brown@intel.com>
Subject: [PATCH 08/16] ACPI: autoload modules - ACPICA modifications
Date: Wed, 25 Jul 2007 01:51:17 -0400
Message-ID: <11853426942213-git-send-email-len.brown@intel.com>
References: <11853426852588-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:9155 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752766AbXGYFvf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Jul 2007 01:51:35 -0400
In-Reply-To: <11853426852588-git-send-email-len.brown@intel.com>
Message-Id: <8c8eb78f673c07b60f31751e1e47ac367c60c6b7.1185342489.git.len.brown@intel.com>
In-Reply-To: <e9b3aba887f47f9cd64de20fec9c333a932b70dc.1185342489.git.len.brown@intel.com>
References: <e9b3aba887f47f9cd64de20fec9c333a932b70dc.1185342489.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>, Len Brown <len.brown@intel.com>

From: Thomas Renninger <trenn@suse.de>

Define standardized HIDs - Rename current acpi_device_id to acpica_device_id

Signed-off-by: Thomas Renninger <trenn@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/events/evrgnini.c    |    2 +-
 drivers/acpi/namespace/nsxfeval.c |    2 +-
 drivers/acpi/utilities/uteval.c   |    4 ++--
 include/acpi/acpi_bus.h           |    5 +++--
 include/acpi/acpi_drivers.h       |   21 +++++++++++++--------
 include/acpi/actypes.h            |    6 +++---
 include/acpi/acutils.h            |    4 ++--
 7 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/drivers/acpi/events/evrgnini.c b/drivers/acpi/events/evrgnini.c
index 23ee7bc..b1aaa0e 100644
--- a/drivers/acpi/events/evrgnini.c
+++ b/drivers/acpi/events/evrgnini.c
@@ -378,7 +378,7 @@ static u8 acpi_ev_match_pci_root_bridge(char *id)
 static u8 acpi_ev_is_pci_root_bridge(struct acpi_namespace_node *node)
 {
 	acpi_status status;
-	struct acpi_device_id hid;
+	struct acpica_device_id hid;
 	struct acpi_compatible_id_list *cid;
 	acpi_native_uint i;
 
diff --git a/drivers/acpi/namespace/nsxfeval.c b/drivers/acpi/namespace/nsxfeval.c
index be4f289..ab65b2c 100644
--- a/drivers/acpi/namespace/nsxfeval.c
+++ b/drivers/acpi/namespace/nsxfeval.c
@@ -440,7 +440,7 @@ acpi_ns_get_device_callback(acpi_handle obj_handle,
 	acpi_status status;
 	struct acpi_namespace_node *node;
 	u32 flags;
-	struct acpi_device_id hid;
+	struct acpica_device_id hid;
 	struct acpi_compatible_id_list *cid;
 	acpi_native_uint i;
 
diff --git a/drivers/acpi/utilities/uteval.c b/drivers/acpi/utilities/uteval.c
index f112af4..0042b7e 100644
--- a/drivers/acpi/utilities/uteval.c
+++ b/drivers/acpi/utilities/uteval.c
@@ -407,7 +407,7 @@ acpi_ut_copy_id_string(char *destination, char *source, acpi_size max_length)
 
 acpi_status
 acpi_ut_execute_HID(struct acpi_namespace_node *device_node,
-		    struct acpi_device_id *hid)
+		    struct acpica_device_id *hid)
 {
 	union acpi_operand_object *obj_desc;
 	acpi_status status;
@@ -609,7 +609,7 @@ acpi_ut_execute_CID(struct acpi_namespace_node * device_node,
 
 acpi_status
 acpi_ut_execute_UID(struct acpi_namespace_node *device_node,
-		    struct acpi_device_id *uid)
+		    struct acpica_device_id *uid)
 {
 	union acpi_operand_object *obj_desc;
 	acpi_status status;
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 5e3dcf3..3f2a22b 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -131,7 +131,7 @@ struct acpi_device_ops {
 struct acpi_driver {
 	char name[80];
 	char class[80];
-	char *ids;		/* Supported Hardware IDs */
+	const struct acpi_device_id *ids; /* Supported Hardware IDs */
 	struct acpi_device_ops ops;
 	struct device_driver drv;
 	struct module *owner;
@@ -341,7 +341,8 @@ int acpi_bus_add(struct acpi_device **child, struct acpi_device *parent,
 int acpi_bus_trim(struct acpi_device *start, int rmdevice);
 int acpi_bus_start(struct acpi_device *device);
 acpi_status acpi_bus_get_ejd(acpi_handle handle, acpi_handle * ejd);
-int acpi_match_ids(struct acpi_device *device, char *ids);
+int acpi_match_device_ids(struct acpi_device *device,
+			  const struct acpi_device_id *ids);
 int acpi_create_dir(struct acpi_device *);
 void acpi_remove_dir(struct acpi_device *);
 
diff --git a/include/acpi/acpi_drivers.h b/include/acpi/acpi_drivers.h
index 5535159..c348ff4 100644
--- a/include/acpi/acpi_drivers.h
+++ b/include/acpi/acpi_drivers.h
@@ -34,16 +34,21 @@
 #define ACPI_BUS_COMPONENT		0x00010000
 #define ACPI_SYSTEM_COMPONENT		0x02000000
 
-/* _HID definitions */
+/*
+ * _HID definitions
+ * HIDs must conform to ACPI spec(6.1.4)
+ * Linux specific HIDs do not apply to this and begin with LNX:
+ */
 
-#define ACPI_POWER_HID			"power_resource"
+#define ACPI_POWER_HID			"LNXPOWER"
 #define ACPI_PROCESSOR_HID		"ACPI0007"
-#define ACPI_SYSTEM_HID			"acpi_system"
-#define ACPI_THERMAL_HID		"thermal"
-#define ACPI_BUTTON_HID_POWERF		"button_power"
-#define ACPI_BUTTON_HID_SLEEPF		"button_sleep"
-#define ACPI_VIDEO_HID			"video"
-#define ACPI_BAY_HID			"bay"
+#define ACPI_SYSTEM_HID			"LNXSYSTM"
+#define ACPI_THERMAL_HID		"LNXTHERM"
+#define ACPI_BUTTON_HID_POWERF		"LNXPWRBN"
+#define ACPI_BUTTON_HID_SLEEPF		"LNXSLPBN"
+#define ACPI_VIDEO_HID			"LNXVIDEO"
+#define ACPI_BAY_HID			"LNXIOBAY"
+
 /* --------------------------------------------------------------------------
                                        PCI
    -------------------------------------------------------------------------- */
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index fe8abc2..e73a389 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -809,7 +809,7 @@ acpi_status(*acpi_walk_callback) (acpi_handle obj_handle,
 
 /* Common string version of device HIDs and UIDs */
 
-struct acpi_device_id {
+struct acpica_device_id {
 	char value[ACPI_DEVICE_ID_LENGTH];
 };
 
@@ -859,8 +859,8 @@ struct acpi_device_info {
 	u32 valid;		/* Indicates which fields below are valid */
 	u32 current_status;	/* _STA value */
 	acpi_integer address;	/* _ADR value if any */
-	struct acpi_device_id hardware_id;	/* _HID value if any */
-	struct acpi_device_id unique_id;	/* _UID value if any */
+	struct acpica_device_id hardware_id;	/* _HID value if any */
+	struct acpica_device_id unique_id;	/* _UID value if any */
 	u8 highest_dstates[4];	/* _sx_d values: 0xFF indicates not valid */
 	struct acpi_compatible_id_list compatibility_id;	/* List of _CIDs if any */
 };
diff --git a/include/acpi/acutils.h b/include/acpi/acutils.h
index a87ef1c..a291854 100644
--- a/include/acpi/acutils.h
+++ b/include/acpi/acutils.h
@@ -354,7 +354,7 @@ acpi_ut_evaluate_numeric_object(char *object_name,
 
 acpi_status
 acpi_ut_execute_HID(struct acpi_namespace_node *device_node,
-		    struct acpi_device_id *hid);
+		    struct acpica_device_id *hid);
 
 acpi_status
 acpi_ut_execute_CID(struct acpi_namespace_node *device_node,
@@ -366,7 +366,7 @@ acpi_ut_execute_STA(struct acpi_namespace_node *device_node,
 
 acpi_status
 acpi_ut_execute_UID(struct acpi_namespace_node *device_node,
-		    struct acpi_device_id *uid);
+		    struct acpica_device_id *uid);
 
 acpi_status
 acpi_ut_execute_sxds(struct acpi_namespace_node *device_node, u8 * highest);
-- 
1.5.3.rc2.22.g69a9b
